//
//  StandardButton.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/27.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class StandardButton: ArtiButton {

    /// TetsuroButton
    ///
    /// - Parameters:
    ///   - text: button text
    ///   - image: optional image
    ///   - normalColor: background color of button when idle status
    ///   - highlightedColor: background color of button when pressed status
    init(text: String, image: UIImage? = nil, titleColor: UIColor, normalColor: UIColor, highlightedColor: UIColor, borderColor: UIColor?) {
        super.init(zoom: 0.90, normalColor: normalColor, highlightedColor: highlightedColor, isShadowEnabled: true)

        setTitle(text, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel?.textAlignment = .center
        setImage(image, for: .normal)
        adjustsImageWhenHighlighted = false
        if image != nil {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24)
        }
        clipsToBounds = true

        if let border = borderColor?.cgColor {
            layer.borderColor = border
            layer.borderWidth = 3.0
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
