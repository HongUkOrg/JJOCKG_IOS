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
    private let contentsView = UIView().then {
        $0.backgroundColor = .clear
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
        $0.layer.zPosition = -1
    }
    
    private let letterOpenButton = UIButton().then {
        $0.setTitle("쪽지 열어보기", for: .normal)
        $0.setTitleColor(.mudBrown, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = .binggrae(ofSize: 12)
    }
    
    private let horizontalSperator = UIView().then {
        $0.backgroundColor = .mudBrown
    }
    
    private let dismissButton = UIButton().then {
        $0.setImage(JGAsset.Icons.cancelBtn.image, for: .normal)
    }
    
    // MARK: - Remake UI Constraints
    override func setupConstraints() {
     
        view.addSubview(contentsView)
        contentsView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(whiteBackgroundView)
        whiteBackgroundView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview().offset(-26)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(166)
        }
        
        view.addSubview(letterContentView)
        letterContentView.snp.remakeConstraints {
            $0.height.equalToSuperview().dividedBy(1.42)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(whiteBackgroundView.snp.top).offset(-60)
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
        
    }
}

