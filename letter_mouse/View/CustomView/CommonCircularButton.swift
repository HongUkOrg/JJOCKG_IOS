//
//  CommonCircularButton.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/27.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CommonCircularButton: UIButton {
    
    var disposeBag = DisposeBag()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        bounds = CGRect(origin: .zero, size: CGSize(width: 36, height: 36))
        adjustsImageWhenHighlighted = false

        self.rx
            .observe(CGRect.self, #keyPath(bounds))
            .subscribe(onNext: { [weak self] (bounds) in
                self?.layer.cornerRadius = (bounds?.height ?? 0.0) / 2.0
            })
            .disposed(by: disposeBag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
