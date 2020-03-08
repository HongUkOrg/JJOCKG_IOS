//
//  SendLetterResultVC.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/27.
//  Copyright © 2020 mac. All rights reserved.
//

import ReactorKit
import RxCocoa
import SnapKit
import Then

final class SendLetterResultVC: BaseViewController, View {
    typealias Reactor = SendLetterReactor
    
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
    private let contentsView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.7
        $0.layer.cornerRadius = 20
    }
    
    private let upperLetterView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let letterContentView = UIView().then {
        $0.backgroundColor = .maize
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let resultLabel = UILabel().then {
        $0.text = "작성이 완료되었습니다."
        $0.textColor = .mudBrown
        $0.textAlignment = .left
        $0.font = .binggrae(ofSize: 16)
    }
    
    private let lowerLetterView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let sealedLocationLabel = UILabel().then {
        $0.text = "남겨진 쪽지 주소"
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = .binggraeBold(ofSize: 12)
    }
    
    private let w3wResultView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.mudBrown.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 22
    }
    
    private let w3wResultLabel = UILabel().then {
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = .binggrae(ofSize: 13)
    }
    
    private let passwordTitleView = UILabel().then {
        $0.text = "봉인 암호"
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = .binggraeBold(ofSize: 12)
    }
    
    private let passwordView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.mudBrown.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 20
    }
    
    private let phoneResultLabel = UILabel().then {
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = .binggrae(ofSize: 13)
    }
    
    private let lockView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.7, radius: 2.0)
    }
    
    private let lockImageView = UIImageView().then {
        $0.image = JGAsset.Icons.icLock20X20.image
        $0.contentMode = .scaleAspectFit
    }
    
    private let shareButton = UIButton().then {
        $0.backgroundColor = .armyGreenTwo
        $0.setTitle("쪽지 공유하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = .binggrae(ofSize: 13)
    }
    
    private let dismissButton = UIButton().then {
        $0.setImage(JGAsset.Icons.cancelBtn.image, for: .normal)
    }
    
    // MARK: - Remake UI Constraints
    override func setupConstraints() {
        
        view.backgroundColor = .clear
        
        view.addSubview(contentsView)
        contentsView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentsView.addSubview(backgroundView)
        backgroundView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview().offset(-27)
            $0.height.equalToSuperview().dividedBy(1.33)
            $0.centerX.equalToSuperview()
        }
        
        contentsView.addSubview(upperLetterView)
        upperLetterView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(backgroundView.snp.width)
            $0.top.equalTo(backgroundView.snp.top)
            $0.height.equalTo(62)
        }
        
        contentsView.addSubview(letterContentView)
        letterContentView.snp.remakeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(46)
            $0.width.equalTo(backgroundView.snp.width).offset(-38)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        letterContentView.addSubview(resultLabel)
        resultLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(20)
        }
        
        contentsView.addSubview(lowerLetterView)
        lowerLetterView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(backgroundView.snp.width)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(letterContentView.snp.bottom)
        }
        
        lowerLetterView.addSubview(w3wResultView)
        w3wResultView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-120)
            $0.height.equalTo(44)
        }
        
        lowerLetterView.addSubview(sealedLocationLabel)
        sealedLocationLabel.snp.remakeConstraints {
            $0.leading.equalTo(w3wResultView.snp.leading).offset(5)
            $0.bottom.equalTo(w3wResultView.snp.top).offset(-10)
        }
        
        w3wResultView.addSubview(w3wResultLabel)
        w3wResultLabel.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
        
        lowerLetterView.addSubview(passwordView)
        passwordView.snp.remakeConstraints {
            $0.top.equalTo(w3wResultView.snp.bottom).offset(50)
            $0.leading.equalTo(w3wResultView.snp.leading)
            $0.width.equalToSuperview().offset(-120)
            $0.height.equalTo(44)
        }
        
        passwordView.addSubview(phoneResultLabel)
        phoneResultLabel.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
        
        lowerLetterView.addSubview(passwordTitleView)
        passwordTitleView.snp.remakeConstraints {
            $0.leading.equalTo(passwordView.snp.leading).offset(5)
            $0.bottom.equalTo(passwordView.snp.top).offset(-5)
        }
        
        contentsView.addSubview(lockView)
        lockView.snp.remakeConstraints {
            $0.size.equalTo(40)
            $0.trailing.equalTo(letterContentView.snp.trailing)
            $0.centerY.equalTo(letterContentView.snp.bottom)
        }
        
        lockView.addSubview(lockImageView)
        lockImageView.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
                
        contentsView.addSubview(dismissButton)
        dismissButton.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(60)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
        
        contentsView.addSubview(shareButton)
        shareButton.snp.remakeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(88)
            $0.bottom.equalTo(dismissButton.snp.top).offset(-16)
        }
        
    }
    
    // MARK: - Binding
    func bind(reactor: Reactor) {
        
        W3WStore.shared
            .w3w
            .filterNil()
            .map { "/// \($0)" }
            .bind(to: w3wResultLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.receiverPhone }
            .filterNil()
            .distinctUntilChanged()
            .do(onNext: { phone in
                Logger.debug("receiver phone : \(phone)")
            })
            .bind(to: phoneResultLabel.rx.text)
            .disposed(by: disposeBag)
        
        shareButton.rx
            .tapThrottle()
            .map { Reactor.Action.smsSendBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        dismissButton.rx
            .tapThrottle()
            .map { Reactor.Action.dismissBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
