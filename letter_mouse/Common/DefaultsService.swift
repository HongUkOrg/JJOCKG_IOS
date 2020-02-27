//
//  DefaultsService.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/27.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import RxSwift

extension DefaultsKeys {
    
    // MARK: - Keys
    static let hasSeenCartoon = DefaultsKey<Bool?>("hasSeenCartoon")
}

protocol DefaultsServiceType {
    static var shared: DefaultsServiceType { get }

    func removeAll()
    func get<T>(_ key: DefaultsKey<T>) -> T
    func get<T>(_ key: DefaultsKey<T?>) -> T?
    func set<T>(_ key: DefaultsKey<T>, as value: T)
    func set<T>(_ key: DefaultsKey<T?>, as value: T?)
}

struct DefaultsService: DefaultsServiceType {

    // MARK: - Properties
    static let shared: DefaultsServiceType = DefaultsService()

    // MARK: - Rx
    private var disposeBag = DisposeBag()

    // MARK: - Initialize
    private init() {

    }

    // MARK: - Methods
    func removeAll() {
        Defaults.removeAll()
        Defaults.synchronize()
    }
    
    func get<T>(_ key: DefaultsKey<T>) -> T {
        return Defaults[key]
    }

    func get<T>(_ key: DefaultsKey<T?>) -> T? {
        return Defaults[key]
    }

    func set<T>(_ key: DefaultsKey<T>, as value: T) {
        Defaults[key] = value
        Defaults.synchronize()
    }

    func set<T>(_ key: DefaultsKey<T?>, as value: T?) {
        Defaults[key] = value
        Defaults.synchronize()
    }
}
