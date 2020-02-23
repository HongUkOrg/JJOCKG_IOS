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
    
    private let pageControlImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let nextPageImageView = UIImageView().then {
        $0.image = JGAsset.Cartoon.nextpage.image
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: Remake UI Constraints
    override func setupConstraints() {
        view.backgroundColor = .white
        
        view.addSubview(skipButton)
        skipButton.snp.remakeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        view.addSubview(pageControlImageView)
        pageControlImageView.snp.remakeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(nextPageImageView)
        nextPageImageView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
    }
    
    // MARK: Binding
    func bind(reactor: Reactor) {
        datasource = self
        
        currentPageRelay
            .distinctUntilChanged()
            .map { Reactor.Action.pageChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.currentPage }
            .map { [weak self] in self?.getPageControlImage($0) }
            .bind(to: pageControlImageView.rx.image)
            .disposed(by: disposeBag)
        
        
        skipButton.rx
            .tapThrottle()
            .map { Reactor.Action.skipBtnClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func getPageControlImage(_ page: Int) -> UIImage? {
        
        switch page {
        case 1:
            return JGAsset.Finder.finder01.image
        case 2:
            return JGAsset.Finder.finder02.image
        case 3:
            return JGAsset.Finder.finder03.image
        case 4:
            return JGAsset.Finder.finder04.image
        case 5:
            return JGAsset.Finder.finder05.image
        case 6:
            return JGAsset.Finder.finder06.image
        case 7:
            return JGAsset.Finder.finder07.image
        case 8:
            return JGAsset.Finder.finder08.image
        default:
            return nil
        }
    }
}

extension CartoonMainVC: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        
        let vc1 = Cartoon01VC()
        let vc2 = Cartoon02VC()
        let vc3 = Cartoon03VC()
        let vc4 = Cartoon04VC()
        let vc5 = Cartoon05VC()
        let vc6 = Cartoon06VC()
        let vc7 = Cartoon07VC()
        let vc8 = Cartoon08VC()
        
        return [vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8]
    }
    
}
