//
//  CartoonMainVC.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ReactorKit

final class CartoonMainVC: BaseViewController, View {
    typealias Reactor = CartoonReactor
    
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
    private let skipButton = UIButton().then {
        $0.setImage(JGAsset.Icons.skip.image, for: .normal)
    }
    
    // MARK: Remake UI Constraints
    override func setupConstraints() {
        view.backgroundColor = .white
        
        view.addSubview(skipButton)
        skipButton.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
    }
    
    // MARK: Binding
    func bind(reactor: Reactor) {
    }
}
