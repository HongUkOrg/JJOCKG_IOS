//
//  ViewController.swift
//  letter_mouse
//
//  Created by mac on 23/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ReactorKit
import Then
import SnapKit
import RxViewController

final class SplashVC: BaseViewController, View {
    
    typealias Reactor = SplashReactor
    
    // MARK: Initialize
    init(reactor: Reactor) {
        super.init()
        defer { self.reactor = reactor }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.debug("SplashVC view did loaded")
    }
    
    // MARK: UI
    private let splashGifImageView = UIImageView().then {
        $0.image = GIFModule().gifImage("main_g")
        $0.contentMode = .scaleAspectFit
    }
    
    private let horizontalDivider = UIView().then {
        $0.backgroundColor = .armyGreen
        $0.alpha = 0.5
    }
    
    private let appNameImageView = UIImageView().then {
        $0.image = JGAsset.Letters.appName.image
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: Remake UI Constraints
    override func setupConstraints() {
        view.backgroundColor = .ganari
        
        view.addSubview(splashGifImageView)
        splashGifImageView.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(horizontalDivider)
        horizontalDivider.snp.remakeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(3)
            $0.top.equalTo(splashGifImageView.snp.bottom).offset(-32)
        }
        
        view.addSubview(appNameImageView)
        appNameImageView.snp.remakeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(45)
        }
    }
    
    // MARK: Binding
    func bind(reactor: Reactor) {
        
        self.rx
            .viewWillAppear
            .delay(.milliseconds(2500), scheduler: MainScheduler.instance)
            .map { (_) in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
}
