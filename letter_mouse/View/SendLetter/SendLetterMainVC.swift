//
//  SendLetterMainVC.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/26.
//  Copyright © 2020 mac. All rights reserved.
//
import ReactorKit
import RxSwift
import RxCocoa
import RxGesture
import RxViewController
import Then
import SnapKit

final class SendLetterMainVC: BaseViewController, ReactorKit.View {
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
    
    // MARK: - Properties
    private var previousPhoneNumberCount: Int = 0
    
    // MARK: - UI
    private let contentsView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.7
        $0.layer.cornerRadius = 16
    }
    
    private let receiverPhoneInputView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.7, radius: 2.0)
    }
    
    private let receiverPhoneInputTextField = UITextField().then {
        $0.font = .binggraeBold(ofSize: 12)
        $0.textColor = .mudBrown
        $0.placeholder = "010-1234-5678"
        $0.keyboardType = .numberPad
        $0.textAlignment = .center
    }
    
    private let receiverNameLabel = UILabel().then {
        $0.text = "받는이"
        $0.textColor = .mudBrown
        $0.textAlignment = .center
        $0.font = UIFont.binggrae(ofSize: 12)
    }
    
    private let contactsImageView = UIImageView().then {
        $0.image = JGAsset.Icons.phoneBook.image
        $0.contentMode = .scaleAspectFit
    }
    
    private let letterView = UIView().then {
        $0.backgroundColor = .maize
        $0.layer.cornerRadius = 16
    }
    
    private let sendLetterButtonView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.3, radius: 2.0)
    }
    
    private let sendLetterButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("쪽지 남기기", for: .normal)
        $0.setTitleColor(.mudBrown, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.binggrae(ofSize: 12)
        $0.layer.cornerRadius = 20
    }
    
    private let dismissButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.mudBrown, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.binggrae(ofSize: 12)
    }
    
    // MARK: - Remake UI Constraints
    override func setupConstraints() {
        
        view.backgroundColor = .clear
        
        view.addSubview(contentsView)
        contentsView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview().offset(-26)
            $0.height.equalToSuperview().dividedBy(1.33)
        }
        
        view.addSubview(receiverPhoneInputView)
        receiverPhoneInputView.snp.remakeConstraints {
            $0.top.equalTo(contentsView.snp.top).offset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(contentsView.snp.width).offset(-150)
        }
        
        receiverPhoneInputView.addSubview(receiverPhoneInputTextField)
        receiverPhoneInputTextField.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(receiverNameLabel)
        receiverNameLabel.snp.remakeConstraints {
            $0.centerY.equalTo(receiverPhoneInputView)
            $0.trailing.equalTo(receiverPhoneInputView.snp.leading).offset(-9)
        }
        
        view.addSubview(contactsImageView)
        contactsImageView.snp.remakeConstraints {
            $0.centerY.equalTo(receiverPhoneInputView)
            $0.leading.equalTo(receiverPhoneInputView.snp.trailing).offset(9)
        }
        
        view.addSubview(letterView)
        letterView.snp.remakeConstraints {
            $0.top.equalTo(receiverPhoneInputView.snp.bottom).offset(12)
            $0.width.equalTo(contentsView.snp.width).offset(-38)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            
        }
        
        view.addSubview(dismissButton)
        dismissButton.snp.remakeConstraints {
            $0.width.equalTo(letterView.snp.width).offset(-70)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        view.addSubview(sendLetterButtonView)
        sendLetterButtonView.snp.remakeConstraints {
            $0.width.equalTo(letterView.snp.width).offset(-70)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalTo(dismissButton.snp.top).offset(-10)
        }
        
        sendLetterButtonView.addSubview(sendLetterButton)
        sendLetterButton.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    func bind(reactor: Reactor) {
        
        receiverPhoneInputTextField.delegate = self
        
        self.view.rx
            .tapGesture()
            .subscribe(onNext: { [weak self] (_) in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        receiverPhoneInputTextField.rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .map(addDashToPhoneNumber)
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: { [weak self] (text) in
                if text.count == 13 {
                    self?.view.endEditing(true)
                }
            })
            .bind(to: receiverPhoneInputTextField.rx.text)
            .disposed(by: disposeBag)
        
        sendLetterButton.rx
            .tapThrottle()
            .map { Reactor.Action.sendLetterBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        dismissButton.rx
            .tapThrottle()
            .map { Reactor.Action.dismissBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
                
    }
    
    private func addDashToPhoneNumber(_ inputString: String) -> String {
        
        var result = inputString
        
        switch inputString.count {
        case 3, 8:
            if previousPhoneNumberCount == 2 || previousPhoneNumberCount == 7 {
                result += "-"
            }
        case 4:
            if result[result.index(result.startIndex, offsetBy: 3)] == "-" {
                break
            }
            result.insert("-", at: result.index(result.startIndex, offsetBy: 3))
        case 9:
            if result[result.index(result.startIndex, offsetBy: 8)] == "-" {
                break
            }
            result.insert("-", at: result.index(result.startIndex, offsetBy: 8))
        default:
            break
        }
        
        previousPhoneNumberCount = inputString.count
        return result
    }
}
