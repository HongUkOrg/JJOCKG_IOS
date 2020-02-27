//
//  ArtiButton.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/27.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArtiButton: CommonCircularButton {
    private let status: BehaviorRelay<ButtonStatus> = BehaviorRelay<ButtonStatus>(value: .up)

    init(zoom: CGFloat = 0.8, duration: TimeInterval = 0.20,
         normalColor: UIColor = UIColor.white, highlightedColor: UIColor = UIColor.white, isShadowEnabled: Bool = false) {
        super.init()
        adjustsImageWhenHighlighted = false

        if isShadowEnabled {
            drawShadow(color: .black, offset: CGSize(width: 0.0, height: 1.0), opacity: 0.15, radius: 4.0)
            layer.backgroundColor = UIColor.white.cgColor
            layer.masksToBounds = false
        }

        self.rx
            .controlEvent([.touchDown, .touchDragEnter])
            .debounce(.milliseconds(50), scheduler: MainScheduler.instance)
            .map { ButtonStatus.down }
            .bind(to: status)
            .disposed(by: disposeBag)
        
        self.rx
            .controlEvent([.touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel])
            .debounce(.milliseconds(150), scheduler: MainScheduler.instance)
            .map { ButtonStatus.up }
            .bind(to: status)
            .disposed(by: disposeBag)

        self.status
            .asObservable()
            .distinctUntilChanged()
            .do(onNext: { [weak self] (status) in
                switch status {
                case .down:
                    self?.backgroundColor = highlightedColor
                    UIView.animate(withDuration: duration / 2.0, animations: { [weak self] in
                        self?.transform = CGAffineTransform(scaleX: zoom, y: zoom)
                    })
                case .up:
                    self?.backgroundColor = normalColor
                    UIView.animateKeyframes(withDuration: duration / 2.0, delay: 0.0, options: .calculationModeCubic, animations: { [weak self] in
                        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.9, animations: { [weak self] in
                            self?.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                        })
                        UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1, animations: { [weak self] in
                            self?.transform = CGAffineTransform.identity
                        })
                    })
                }
            })
            .subscribe {}
            .disposed(by: disposeBag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArtiButton {
    enum ButtonStatus {
        case up
        case down
    }
}
