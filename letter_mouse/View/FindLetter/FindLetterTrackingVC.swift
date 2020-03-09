//
//  FindLetterTrackingVC.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/29.
//  Copyright © 2020 mac. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import GoogleMaps

final class FindLetterTrackingVC: BaseViewController, View {
    typealias Reactor = FindLetterReactor
    
    // MARK: - Initialize
    init(reactor: Reactor) {
        defer { self.reactor = reactor }
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI
    private let googleMapView = GMSMapView().then {
        $0.isMyLocationEnabled = true
        $0.settings.myLocationButton = true
        $0.layer.zPosition = -2
    }
    
    private let upperSafeAreaView = UIView().then {
        $0.backgroundColor = .maize
    }
    
    private let upperView = UIView().then {
        $0.backgroundColor = .maize
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.layer.masksToBounds = true
    }
    
    private let mainTitleLabel = UILabel().then {
        $0.text = "쪽지 찾기"
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = UIFont.binggraeBold(ofSize: 12)
    }
    
    private let infoBtnImageView = UIImageView().then {
        $0.image = JGAsset.Icons.btInfo32X32.image
        $0.contentMode = .scaleAspectFit
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.7, radius: 2.0)
    }
    
    private let trackingView = UIView().then {
        $0.backgroundColor = .whiteAlpha9
        $0.layer.cornerRadius = 16
    }
    
    private let trackingDiscriptionLabel = UILabel().then {
        $0.text = "거리 계산중..."
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = .binggraeBold(ofSize: 16)
        $0.numberOfLines = 2
    }
    
    private let whiteBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.masksToBounds = true
    }
    
    private let letterContentView = UIView().then {
        $0.backgroundColor = .maize
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.zPosition = -1
        $0.isUserInteractionEnabled = false
    }
    
    private let letterContentLabel = UILabel().then {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let attributes = [NSAttributedString.Key.paragraphStyle: style,
                          NSAttributedString.Key.font: UIFont.binggrae(ofSize: 14),
                          NSAttributedString.Key.foregroundColor: UIColor.mudBrown,
        ]
        
        $0.numberOfLines = 0
        $0.textColor = .mudBrown
        $0.textAlignment = .left
        $0.attributedText = NSAttributedString(string: "아아아\n아아아\n아아\n아아\n아아\n아아\n아아\n아아\n아아\n", attributes: attributes)
    }
    
    private let letterOpenButton = UIButton().then {
        $0.setTitle("쪽지 열어보기", for: .normal)
        $0.setTitleColor(.mudBrown, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = .binggrae(ofSize: 12)
        $0.isEnabled = false
    }
    
    private let horizontalSperator = UIView().then {
        $0.backgroundColor = .mudBrown
        $0.alpha = 0.8
    }
    
    private let dismissButton = UIButton().then {
        $0.setImage(JGAsset.Icons.cancelBtn.image, for: .normal)
    }
    
    // MARK: - Remake UI Constraints
    override func setupConstraints() {
     
        view.addSubview(googleMapView)
        googleMapView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(trackingView)
        trackingView.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        trackingView.addSubview(trackingDiscriptionLabel)
        trackingDiscriptionLabel.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(trackingView.snp.bottom).offset(-50)
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
        
        view.addSubview(whiteBackgroundView)
        whiteBackgroundView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview().offset(-26)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        view.addSubview(letterContentView)
        letterContentView.snp.remakeConstraints {
            $0.height.equalToSuperview().dividedBy(2)
            $0.width.equalTo(whiteBackgroundView.snp.width).offset(-40)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(whiteBackgroundView.snp.top).offset(-40)
        }
        
        letterContentView.addSubview(letterContentLabel)
        letterContentLabel.snp.remakeConstraints {
            $0.width.equalToSuperview().offset(-65)
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
        }
        
        whiteBackgroundView.addSubview(letterOpenButton)
        letterOpenButton.snp.remakeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        whiteBackgroundView.addSubview(horizontalSperator)
        horizontalSperator.snp.remakeConstraints {
            $0.height.equalTo(2)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(letterOpenButton.snp.bottom)
        }
        
        whiteBackgroundView.addSubview(dismissButton)
        dismissButton.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(horizontalSperator.snp.bottom).offset(30)
        }
        
    }
    
    // MARK: - Binding
    func bind(reactor: Reactor) {
        
        self.rx
            .viewWillAppear
            .take(1)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (_) in
                self?.drawLetterSubLine()
            })
            .disposed(by: disposeBag)
        
        let canRead = reactor.state
            .map { $0.canRead }
            .share()
        
        canRead
            .map { $0 ? UIColor.white : UIColor(white: 0.8, alpha: 0.8) }
            .bind(to: letterOpenButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        canRead
            .bind(to: letterOpenButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        canRead
            .map { $0 ? UIColor.maize.withAlphaComponent(0.5) : UIColor.whiteAlpha9 }
            .bind(to: trackingView.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        letterOpenButton.rx
            .tapThrottle()
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] (_) in
                // FIXME: animation doesn't work if layoutSubview is not called in close down
                if reactor.currentState.letterOpend == false {
                    self?.letterOpenButton.setTitle("쪽지 닫기", for: .normal)
                    self?.view.layoutIfNeeded()
                    UIView.animate(withDuration: 0.5) {
                        self?.letterContentView.frame.origin.y = self?.getLetterOriginY(open: true) ?? 0
                    }
                } else {
                    self?.letterOpenButton.setTitle("쪽지 열어보기", for: .normal)
                    UIView.animate(withDuration: 0.5) {
                        self?.letterContentView.frame.origin.y = self?.getLetterOriginY(open: false) ?? 0
                    }
                }
            })
            .map { Reactor.Action.letterOpenToggle }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.letterContent }
            .filterNil()
            .bind(to: letterContentLabel.rx.text)
            .disposed(by: disposeBag)
        
        dismissButton.rx
            .tapThrottle()
            .map { Reactor.Action.returnToMain }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .map { (_) in Reactor.Action.checkDistance }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.distanceToLetter }
            .map { "쪽지까지\n앞으로 \($0)미터!" }
            .bind(to: trackingDiscriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.letterLocation }
            .filterNil()
            .take(1)
            .subscribe(onNext: { [weak self] (locationModel) in
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: locationModel.latitude,
                                                         longitude: locationModel.longitude)
                marker.title = "쪽지"
                marker.icon = JGAsset.Icons.currentLetter.image
                marker.map = self?.googleMapView
                
                self?.googleMapView.selectedMarker = marker
                self?.googleMapView.camera = GMSCameraPosition(latitude: locationModel.latitude,
                                                               longitude: locationModel.longitude,
                                                               zoom: 13.0)
            })
            .disposed(by: disposeBag)
    }
    
    private func drawLetterSubLine() {
        let textViewHeight = letterContentView.frame.height
        let lineNumber = Int( (textViewHeight - 59.0) / 29.0 )
        
        for i in 0..<lineNumber {
            let lineSpacing = i * 29 + 59
            let subLine = LetterSubLine()
            letterContentView.addSubview(subLine)
            subLine.snp.remakeConstraints {
                $0.width.equalToSuperview().offset(-60)
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(lineSpacing)
                $0.height.equalTo(1)
            }
        }
    }
    
    private func getLetterOriginY(open: Bool) -> CGFloat {
        let letterOffset = (UIScreen.main.bounds.height / 2.0) - 40
        
        if open {
            return whiteBackgroundView.frame.origin.y - letterOffset
        } else {
            return whiteBackgroundView.frame.origin.y - 40.0
        }
    }
}

