//
//  MainVC.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import GoogleMaps
import RxSwift

final class MainVC: BaseViewController, View {
    
    typealias Reactor = MainReactor
    
    // MARK: Initialize
    init(reactor: Reactor) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UI
    private let googleMapView = GMSMapView().then {
        $0.isMyLocationEnabled = true
        $0.settings.myLocationButton = true
    }
    
    private let upperSafeAreaView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.7
    }
    
    private let upperView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.7
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.layer.masksToBounds = true
    }
    
    private let mainTitleLabel = UILabel().then {
        $0.text = "나의 현재 주소"
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = UIFont.binggraeBold(ofSize: 12)
    }
    
    private let infoBtnImageView = UIImageView().then {
        $0.image = JGAsset.Icons.btInfo32X32.image
        $0.contentMode = .scaleAspectFit }
    
    private let currentW3WView = UIView().then {
        $0.backgroundColor = .maize
        $0.layer.cornerRadius = 20
        $0.drawShadow()
    }
    
    private let W3WLabel = UILabel().then {
        $0.text = "/// 허브.숟가락.창문"
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = UIFont.binggrae(ofSize: 12)
    }
    
    private let mainArchonImageView = UIImageView().then {
        $0.image = JGAsset.Icons.mainArchon.image
        $0.contentMode = .scaleAspectFit
    }
    
    private let sendLetterButton = UIButton().then {
        $0.titleLabel?.textAlignment = .center
        $0.setImage(JGAsset.Icons.imMenuLeft104X46.image, for: .normal)
    }
    
    private let sendLetterLabel = UILabel().then {
        $0.text = "쪽지 남기기"
        $0.textColor = .maize
        $0.textAlignment = .center
        $0.font = UIFont.binggraeBold(ofSize: 14)
    }
    
    private let findLetterButton = UIButton().then {
        $0.titleLabel?.textAlignment = .center
        $0.setImage(JGAsset.Icons.imMenuRight104X46.image, for: .normal)
    }
    
    private let findLetterLabel = UILabel().then {
        $0.text = "쪽지 찾기"
        $0.textColor = .maize
        $0.textAlignment = .center
        $0.font = UIFont.binggraeBold(ofSize: 14)
    }
    
    // MARK: Remake UI Constraints
    override func setupConstraints() {
        
        view.backgroundColor = .ganari
        
        view.addSubview(googleMapView)
        googleMapView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(upperSafeAreaView)
        upperSafeAreaView.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets.top)
            $0.width.equalToSuperview()
        }
        
        view.addSubview(upperView)
        upperView.snp.remakeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(upperSafeAreaView.snp.bottom)
            $0.height.equalTo(60)
        }
        
        view.addSubview(currentW3WView)
        currentW3WView.snp.remakeConstraints {
            $0.width.equalToSuperview().offset(-90)
            $0.height.equalTo(38)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(upperView.snp.bottom).offset(-10)
        }
        
        currentW3WView.addSubview(W3WLabel)
        W3WLabel.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(mainTitleLabel)
        mainTitleLabel.snp.remakeConstraints {
            $0.bottom.equalTo(upperView.snp.bottom).offset(-22)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(infoBtnImageView)
        infoBtnImageView.snp.remakeConstraints {
            $0.size.equalTo(32)
            $0.centerY.equalTo(mainTitleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(mainArchonImageView)
        mainArchonImageView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32)
        }
        
        view.addSubview(sendLetterButton)
        sendLetterButton.snp.remakeConstraints {
            $0.bottom.equalTo(mainArchonImageView.snp.top).offset(-9)
            $0.trailing.equalTo(view.snp.centerX).offset(-12)
        }
        
        sendLetterButton.addSubview(sendLetterLabel)
        sendLetterLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview().offset(-3.5)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(findLetterButton)
        findLetterButton.snp.remakeConstraints {
            $0.bottom.equalTo(mainArchonImageView.snp.top).offset(-9)
            $0.leading.equalTo(view.snp.centerX).offset(12)
        }
        
        findLetterButton.addSubview(findLetterLabel)
        findLetterLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview().offset(-3.5)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: Binding
    func bind(reactor: Reactor) {
        
        infoBtnImageView.rx
            .tapGestureThrottle()
            .map { Reactor.Action.infoBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        let location = reactor.locationModule
            .locationRelay
            .filterNil()
            .share()
        
        location
            .take(1)
            .subscribe(onNext: { [weak self] location in
                self?.googleMapView.camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                                                      longitude: location.longitude,
                                                                      zoom: 18.0)
            })
            .disposed(by: disposeBag)
        
        Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .map { [weak self ] (_) in self?.googleMapView.myLocation }
            .distinctUntilChanged()
            .filterNil()
            .map({ (location) -> MainReactor.Action in
                let latitude: Double = location.coordinate.latitude
                let longitude: Double = location.coordinate.longitude
                let locationModel = LocationModel(latitude: latitude, longitude: longitude)
                return Reactor.Action.locationChanged(locationModel)
            })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.what3Words }
            .bind(to: W3WLabel.rx.text)
            .disposed(by: disposeBag)
        
        sendLetterButton.rx
            .tapThrottle()
            .map { Reactor.Action.sendLetterBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        findLetterButton.rx
            .tapThrottle()
            .map { Reactor.Action.findLetterBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
}
