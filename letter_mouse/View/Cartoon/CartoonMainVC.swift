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

final class CartoonMainVC: EZSwipeController, View {
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
        datasource = self
    }
}

extension CartoonMainVC: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = Cartoon01VC()
        let vc2 = Cartoon02VC()
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "cartoon_03_view") as! cartoon03ViewController
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "cartoon_04_view") as! cartoon04ViewController
        let vc5 = storyBoard.instantiateViewController(withIdentifier: "cartoon_05_view") as! cartoon05ViewController
        let vc6 = storyBoard.instantiateViewController(withIdentifier: "cartoon_06_view") as! cartoon06ViewController
        let vc7 = storyBoard.instantiateViewController(withIdentifier: "cartoon_07_view") as! cartoon07ViewController
        let vc8 = storyBoard.instantiateViewController(withIdentifier: "cartoon_08_view") as! cartoon08ViewController
        
        return [vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8]
    }
    
}
