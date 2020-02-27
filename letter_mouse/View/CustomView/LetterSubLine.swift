//
//  letterSubLine.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/27.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SnapKit

class LetterSubLine: UIView {

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
