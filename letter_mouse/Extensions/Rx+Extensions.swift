//
//  Rx+Extensions.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxOptional
import RxGesture

extension Single where Element: OptionalType {
    /// syntax shortcut
    func filterNil() -> Single<Element.Wrapped> {
        return self.asObservable().flatMap { element -> Observable<Element.Wrapped> in
            guard let value = element.value else {
                return Observable<Element.Wrapped>.empty()
            }
            return Observable<Element.Wrapped>.just(value)
        }
        .asSingle()
    }
}

extension Reactive where Base: CALayer {
    var width: Binder<CGFloat> {
        return Binder(base) { layer, width in
            layer.frame = CGRect(origin: .zero, size: CGSize(width: width, height: layer.bounds.height))
        }
    }

    var border: Binder<(Bool, UIColor)> {
        return Binder(base) { (layer, arg) in
            let (highlight, color) = arg
            if highlight {
                layer.drawBorder(with: color, width: 1.0)
            } else {
                layer.drawBorder(with: .clear, width: 0.0)
            }
        }
    }
}

extension Reactive where Base: UIView {
    var backgroundColor: Binder<UIColor> {
        return Binder(base) { view, color in
            view.backgroundColor = color
        }
    }
}

extension Reactive where Base: UICollectionView {
    var contentInsets: Binder<UIEdgeInsets> {
        return Binder(base) { view, insets in
            view.contentInset = insets
        }
    }

    var allowsSelection: Binder<Bool> {
        return Binder(base) { view, selection in
            view.allowsSelection = selection
        }
    }

    var allowsMultipleSelection: Binder<Bool> {
        return Binder(base) { view, selection in
            view.allowsMultipleSelection = selection
        }
    }
}

extension Reactive where Base: UIView {
    func tapGestureThrottle(_ dueTime: RxTimeInterval = .milliseconds(1000), latest: Bool = true) -> Observable<Void> {
        return self.tapGesture()
            .throttle(dueTime, latest: latest, scheduler: MainScheduler.instance)
            .map { _ in return }
    }
}

extension Reactive where Base: UIButton {
    func tapThrottle(_ dueTime: RxTimeInterval = .milliseconds(1000), latest: Bool = true) -> Observable<Void> {
        return self.tap
            .throttle(dueTime, latest: latest, scheduler: MainScheduler.instance)
            .map { _ in return }
    }
}

extension Reactive where Base: UILabel {
    var textColor: Binder<UIColor> {
        return Binder(base) { label, color in
            label.textColor = color
        }
    }
}

extension Reactive where Base: UIView {
    // assert(view.layer is CAGradientLayer), if fails, noop.
    var gradientColor: Binder<[UIColor]> {
        return Binder(base) { view, colors in
            guard let layer = view.layer as? CAGradientLayer else { return }
            layer.colors = colors.map { $0.cgColor }
        }
    }

//    var itemGradientColor: Binder<ItemGradeGradientColor?> {
//        return Binder(base) { view, color in
//            guard let layer = view.layer as? CAGradientLayer else { return }
//            layer.colors = color?.colors.map { $0.cgColor }
//            layer.locations = color?.locations
//            (layer.startPoint, layer.endPoint) = color?.direction ?? CGPoint.toBottom
//        }
//    }
}

/// App state (lifecycle)
enum AppState: Equatable, Hashable {
    case active
    case inactive
    case background
    case terminated
}

extension RxSwift.Reactive where Base: NotificationCenter {
    var keyboardWillShow: Observable<CGFloat> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .map { $0.userInfo }
            .filterNil()
            .map { $0[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .filterNil()
            .map { $0.cgRectValue.height }
        
    }
    
    var keyboardWillHide: Observable<CGFloat> {
        return NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .map { $0.userInfo }
            .filterNil()
            .map { $0[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .filterNil()
            .map { $0.cgRectValue.height }
        
    }
}

extension RxSwift.Reactive where Base: UIApplication {
    var applicationDidBecomeActive: Observable<AppState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.didBecomeActiveNotification)
            .map { _ in .active }
    }

    var applicationWillEnterForeground: Observable<AppState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.willEnterForegroundNotification)
            .map { _ in .inactive }
    }

    var applicationWillResignActive: Observable<AppState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.willResignActiveNotification)
            .map { _ in .inactive }
    }

    var applicationDidEnterBackground: Observable<AppState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.didEnterBackgroundNotification)
            .map { _ in .background }
    }

    var applicationWillTerminate: Observable<AppState> {
        return NotificationCenter.default.rx
            .notification(UIApplication.willTerminateNotification)
            .map { _ in .terminated }
    }

    var appState: Observable<AppState> {
        return Observable.of(
            applicationDidBecomeActive,
            applicationWillEnterForeground,
            applicationWillResignActive,
            applicationDidEnterBackground,
            applicationWillTerminate
            )
            .merge()
    }
}

extension Observable {

    public func bind(animated observers: [Binder<Element>]) -> Disposable {
        return self.subscribe { event in
            observers.forEach { $0.on(event) }
        }
    }
    
    public func bind(animated observers: Binder<Element>...) -> Disposable {
        return self.subscribe { event in
            observers.forEach { $0.on(event) }
        }
    }
}
