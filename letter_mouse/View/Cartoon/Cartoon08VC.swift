//
//  cartoon04ViewController.swift
//  letter_mouse
//
//  Created by mac on 27/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import RxViewController
import RxSwift

class Cartoon08VC: BaseViewController {

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did loaded on main")
        bind()
    }

    // MARK: UI
    private let cartoonImageView = UIImageView().then {
        $0.image = JGAsset.Cartoon.cartoon08.image
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: Remake UI Constaints
    override func setupConstraints() {
        view.addSubview(cartoonImageView)
        cartoonImageView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(-30)
        }
    }
    
    // MARK: - Binding
    func bind() {
        self.rx
            .viewWillAppear
            .subscribe(onNext: { (_) in
                Logger.debug("Tutorial Cartoon completed")
                DefaultsService.shared.set(.hasSeenCartoon, as: true)
            })
            .disposed(by: disposeBag)
    }
}
