//
//  cartoon01ViewController.swift
//  letter_mouse
//
//  Created by mac on 26/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class Cartoon01VC: BaseViewController {

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did loaded on main")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private let verticalCartoonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    // MARK: UI
    private let upperCartoonImageView = UIImageView().then {
        $0.image = JGAsset.Cartoon.cartoon01.image
        $0.contentMode = .scaleAspectFit
    }
    
    private let lowerCartoonImageView = UIImageView().then {
        $0.image = JGAsset.Cartoon.cartoon012.image
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: Remake UI Constraints
    override func setupConstraints() {
        
        view.addSubview(verticalCartoonStackView)
        verticalCartoonStackView.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
        
        verticalCartoonStackView.addArrangedSubview(upperCartoonImageView)
        verticalCartoonStackView.addArrangedSubview(lowerCartoonImageView)

    }
}
