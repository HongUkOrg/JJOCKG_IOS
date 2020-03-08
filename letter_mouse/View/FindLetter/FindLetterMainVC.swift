//
//  FindLetterMainVC.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/28.
//  Copyright © 2020 mac. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class FindLetterMainVC: BaseViewController, View {
    
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
    
    // MARK: - Properteis
    private var previousPhoneNumberCount: Int = 0
    
    // MARK: - UI
    private let contentsView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.95
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let passwordInputView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.7, radius: 2.0)
    }
    
    private let passwordInputTextField = UITextField().then {
        $0.font = .binggraeBold(ofSize: 12)
        $0.textColor = .mudBrown
        $0.placeholder = "회색고양이"
        $0.keyboardType = .default
        $0.textAlignment = .center
    }
    
    private let passwordTitleLabel = UILabel().then {
        $0.text = "봉인 암호"
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = UIFont.binggrae(ofSize: 12)
    }
    
    private let receivedW3wLabel = UILabel().then {
        $0.text = "받은 세단어 주소"
        $0.textColor = .mudBrown
        $0.textAlignment = .left
        $0.font = .binggrae(ofSize: 12)
    }
    
    private let w3wView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.7, radius: 2.0)
    }
    
    private let w3wHorizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    private let w3wPrefixLabel = UILabel().then {
        $0.text = "/// "
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = .binggraeBold(ofSize: 12)
    }
    
    private let w3wFirstTextField = UITextField().then {
        $0.placeholder = "주소를"
        $0.font = .binggrae(ofSize: 12)
    }
    
    private let w3wSeperator = UILabel().then {
        $0.text = "ㄷ"
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = .binggraeBold(ofSize: 12)
    }
    
    private let w3wSecondTextField = UITextField().then {
        $0.placeholder = "여기에"
        $0.font = .binggrae(ofSize: 12)
    }
    
    private let w3wSeperator2 = UILabel().then {
        $0.text = "."
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = .binggraeBold(ofSize: 12)
    }
    
    private let w3wThirdTextField = UITextField().then {
        $0.placeholder = "입력!"
        $0.font = .binggrae(ofSize: 12)
    }
    
    private let findLetterButtonView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.3, radius: 2.0)
    }
    
    private let findLetterButton = StandardButton(text: "쪽지 찾기", image: nil, titleColor: .mudBrown, normalColor: .maize, highlightedColor: UIColor(white: 0.9, alpha: 0.9), borderColor: nil).then {
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.binggrae(ofSize: 12)
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.3, radius: 2.0)
    }
    
    private let cancelButtonView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.3, radius: 2.0)
    }
    
    private let cancelButton = StandardButton(text: "취소", image: nil, titleColor: .white, normalColor: .armyGreenTwo, highlightedColor: UIColor(white: 0.9, alpha: 0.9), borderColor: nil).then {
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.binggrae(ofSize: 12)
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.3, radius: 2.0)
    }
    
    // MARK: - Remake UI Constraints
    override func setupConstraints() {
        
        view.addSubview(contentsView)
        contentsView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentsView.addSubview(backgroundView)
        backgroundView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(350)
            $0.width.equalToSuperview().offset(-27)
            $0.bottom.equalToSuperview()
        }
        
        backgroundView.addSubview(receivedW3wLabel)
        receivedW3wLabel.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(30)
        }
        
        contentsView.addSubview(w3wView)
        w3wView.snp.remakeConstraints {
            $0.top.equalTo(receivedW3wLabel.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(backgroundView.snp.width).offset(-60)
            $0.centerX.equalToSuperview()
        }
        
        w3wView.addSubview(w3wHorizontalStackView)
        w3wHorizontalStackView.snp.remakeConstraints {
            $0.width.equalToSuperview().offset(-60)
            $0.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        w3wHorizontalStackView.addArrangedSubview(w3wPrefixLabel)
        w3wHorizontalStackView.addArrangedSubview(w3wFirstTextField)
        w3wHorizontalStackView.addArrangedSubview(w3wSeperator)
        w3wHorizontalStackView.addArrangedSubview(w3wSecondTextField)
        w3wHorizontalStackView.addArrangedSubview(w3wSeperator2)
        w3wHorizontalStackView.addArrangedSubview(w3wThirdTextField)
        
        w3wPrefixLabel.snp.remakeConstraints {
            $0.width.equalTo(40)
        }
        
        w3wFirstTextField.snp.remakeConstraints {
            $0.width.equalTo(50)
        }
        
        w3wSeperator.snp.remakeConstraints {
            $0.width.equalTo(2)
        }
        
        w3wSecondTextField.snp.remakeConstraints {
            $0.width.equalTo(50)
        }
        
        w3wSeperator2.snp.remakeConstraints {
            $0.width.equalTo(2)
        }
        
        w3wThirdTextField.snp.remakeConstraints {
            $0.width.equalTo(50)
        }
        
        contentsView.addSubview(passwordTitleLabel)
        passwordTitleLabel.snp.remakeConstraints {
            $0.top.equalTo(w3wView.snp.bottom).offset(24)
            $0.leading.equalTo(receivedW3wLabel.snp.leading)
        }
        
        contentsView.addSubview(passwordInputView)
        passwordInputView.snp.remakeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(backgroundView).offset(-60)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTitleLabel.snp.bottom).offset(10)
        }
        
        passwordInputView.addSubview(passwordInputTextField)
        passwordInputTextField.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(-20)
        }
        
        contentsView.addSubview(findLetterButtonView)
        findLetterButtonView.snp.remakeConstraints {
            $0.width.equalTo(backgroundView.snp.width).offset(-60)
            $0.height.equalTo(40)
            $0.top.equalTo(passwordInputView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        findLetterButtonView.addSubview(findLetterButton)
        findLetterButton.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentsView.addSubview(cancelButtonView)
        cancelButtonView.snp.remakeConstraints {
            $0.width.equalTo(backgroundView.snp.width).offset(-60)
            $0.height.equalTo(40)
            $0.top.equalTo(findLetterButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        cancelButtonView.addSubview(cancelButton)
        cancelButton.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

    }
    
    // MARK: - Binding
    func bind(reactor: Reactor) {

        self.rx
            .viewWillDisappear
            .take(1)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (_) in
                Logger.debug("will disappear")
                self?.contentsView.isHidden = true
            })
            .disposed(by: disposeBag)
        
        contentsView.rx
            .tapGesture()
            .subscribe(onNext: { [weak self] (tap) in
                let location = tap.location(in: self?.contentsView)
                guard let contain = self?.backgroundView.frame.contains(location), contain else {
                    self?.view.endEditing(true)
                    return
                }
            })
            .disposed(by: disposeBag)
        
        cancelButton.rx
            .tapThrottle()
            .map { Reactor.Action.cancelBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        findLetterButton.rx
            .tapThrottle()
            .map { Reactor.Action.findLetterBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordInputTextField.rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.receiverPhoneChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordInputTextField.rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .map(limitMaximumStringCount)
            .bind(to: passwordInputTextField.rx.text)
            .disposed(by: disposeBag)
        
        w3wFirstTextField.rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.firstWordChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        w3wSecondTextField.rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.secondWordChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        w3wThirdTextField.rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.thirdWordChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    
        NotificationCenter.default.rx
            .keyboardWillShow
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (keyboardHeight) in
                guard self?.view.frame.origin.y == 0 else { return }
                UIView.animate(withDuration: 0.3) {
                    self?.view.frame.origin.y -= keyboardHeight
                }
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .keyboardWillHide
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (keyboardHeight) in
                guard self?.view.frame.origin.y != 0 else { return }
                UIView.animate(withDuration: 0.3) {
                    self?.view.frame.origin.y = 0
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func limitMaximumStringCount(_ inputString: String) -> String {
        
        var result = inputString
        
        if result.count > 10 {
            result = String(result.prefix(10))
        }
        
        return result
    }
}
