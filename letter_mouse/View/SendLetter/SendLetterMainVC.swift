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
import RxKeyboard
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
        $0.backgroundColor = .clear
    }
    
    private let backgroundWhiteView = UIView().then {
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
    
    private let letterContentTextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.textContainer.maximumNumberOfLines = 10
    }
    
    private let sendLetterButtonView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 20
        $0.drawShadow(color: .black, offset: CGSize(width: 2, height: 2), opacity: 0.3, radius: 2.0)
    }
    
    private let sendLetterButton = StandardButton(text: "쪽지 남기기", image: nil, titleColor: .mudBrown, normalColor: .white, highlightedColor: UIColor(white: 0.9, alpha: 0.9), borderColor: nil).then {
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
            $0.edges.equalToSuperview()
        }
        
        contentsView.addSubview(backgroundWhiteView)
        backgroundWhiteView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview().offset(-26)
            $0.height.equalToSuperview().dividedBy(1.33)
        }
        
        contentsView.addSubview(receiverPhoneInputView)
        receiverPhoneInputView.snp.remakeConstraints {
            $0.top.equalTo(backgroundWhiteView.snp.top).offset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(backgroundWhiteView.snp.width).offset(-150)
        }
        
        receiverPhoneInputView.addSubview(receiverPhoneInputTextField)
        receiverPhoneInputTextField.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        contentsView.addSubview(receiverNameLabel)
        receiverNameLabel.snp.remakeConstraints {
            $0.centerY.equalTo(receiverPhoneInputView)
            $0.trailing.equalTo(receiverPhoneInputView.snp.leading).offset(-9)
        }
        
        contentsView.addSubview(contactsImageView)
        contactsImageView.snp.remakeConstraints {
            $0.centerY.equalTo(receiverPhoneInputView)
            $0.leading.equalTo(receiverPhoneInputView.snp.trailing).offset(9)
        }
        
        contentsView.addSubview(letterView)
        letterView.snp.remakeConstraints {
            $0.top.equalTo(receiverPhoneInputView.snp.bottom).offset(12)
            $0.width.equalTo(backgroundWhiteView.snp.width).offset(-38)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            
        }
        
        contentsView.addSubview(dismissButton)
        dismissButton.snp.remakeConstraints {
            $0.width.equalTo(letterView.snp.width).offset(-70)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        contentsView.addSubview(sendLetterButtonView)
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
        
        contentsView.addSubview(letterContentTextView)
        letterContentTextView.snp.remakeConstraints {
            $0.width.equalTo(letterView.snp.width).offset(-55)
            $0.top.equalTo(letterView.snp.top).offset(30)
            $0.bottom.equalTo(sendLetterButtonView.snp.top).offset(-30)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    func bind(reactor: Reactor) {
        
        receiverPhoneInputTextField.delegate = self
        
        self.rx
            .viewWillAppear
            .take(1)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (_) in
                self?.drawLetterSubLine()
            })
            .disposed(by: disposeBag)
        
        self.view.rx
            .tapGesture()
            .subscribe(onNext: { [weak self] (_) in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        let receiverPhoneText = receiverPhoneInputTextField.rx
            .text
            .orEmpty
            .distinctUntilChanged()
            
        receiverPhoneText
            .map(addDashToPhoneNumber)
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: { [weak self] (text) in
                if text.count == 13 {
                    self?.view.endEditing(true)
                }
            })
            .bind(to: receiverPhoneInputTextField.rx.text)
            .disposed(by: disposeBag)
        
        receiverPhoneText
            .map(Reactor.Action.receiverPhoneChanged)
            .bind(to: reactor.action)
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
        
        letterContentTextView.rx
            .text
            .orEmpty
            .map { (text) in
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 10
                let attributes = [NSAttributedString.Key.paragraphStyle: style,
                                  NSAttributedString.Key.font: UIFont.binggrae(ofSize: 14),
                                  NSAttributedString.Key.foregroundColor: UIColor.mudBrown]
                return NSAttributedString(string: text, attributes: attributes)
            }
            .bind(to: letterContentTextView.rx.attributedText)
            .disposed(by: disposeBag)
        
        letterContentTextView.rx
            .didBeginEditing
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (_) in
                UIView.animate(withDuration: 0.3) { [weak self] in
                    guard let originalHeight = self?.backgroundWhiteView.frame.height else {
                        return
                    }
                    self?.contentsView.frame.origin.y -= (UIScreen.main.bounds.height - originalHeight)
                }
            })
            .disposed(by: disposeBag)
        
        letterContentTextView.rx
            .didEndEditing
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.contentsView.frame.origin.y = 0
                }
            })
            .disposed(by: disposeBag)
        
        letterContentTextView.rx
            .text
            .orEmpty
            .map(Reactor.Action.letterContentCahnged)
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
    
    private func drawLetterSubLine() {
        let textViewHeight = letterContentTextView.frame.height
        let lineNumber = Int( (textViewHeight - 29.0) / 29.0 )
        
        for i in 0..<lineNumber {
            let lineSpacing = i * 29 + 29
            let subLine = LetterSubLine()
            contentsView.addSubview(subLine)
            subLine.snp.remakeConstraints {
                $0.width.equalTo(letterContentTextView.snp.width).offset(-10)
                $0.centerX.equalToSuperview()
                $0.top.equalTo(letterContentTextView.snp.top).offset(lineSpacing)
                $0.height.equalTo(1)
            }
        }
    }
}
