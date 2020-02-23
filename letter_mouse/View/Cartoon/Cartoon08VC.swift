//
//  cartoon04ViewController.swift
//  letter_mouse
//
//  Created by mac on 27/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class Cartoon08VC: BaseViewController {

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did loaded on main")
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
}
