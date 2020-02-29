//
//  LetterService.swift
//  letter_mouse
//
//  Created by bleo on 2020/03/01.
//  Copyright © 2020 mac. All rights reserved.
//

import CoreLocation
import RxSwift
import RxRelay

protocol LetterServiceType {
    var distance: Int? { get }
    var currentLocation: BehaviorRelay<LocationModel?> { get set }
    var letterLocation: BehaviorRelay<LocationModel?> { get set }
    var w3w: BehaviorRelay<String?> { get set }
    
    func reset()
}

class LetterService: LetterServiceType {
    
    var distance: Int? {
        get {
            return calculateDistance(currentLocation.value, letterLocation.value)
        }
    }
    var currentLocation: BehaviorRelay<LocationModel?> = BehaviorRelay<LocationModel?>(value: nil)
    var letterLocation: BehaviorRelay<LocationModel?> = BehaviorRelay<LocationModel?>(value: nil)
    var w3w: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    func reset() {
        letterLocation.accept(nil)
    }
    
    private func calculateDistance(_ first: LocationModel?, _ second: LocationModel?) -> Int? {
        guard let first = first, let second = second else { return nil }
        let firstLocation = CLLocation(latitude: first.latitude, longitude: first.longitude)
        let secondLoaction = CLLocation(latitude: second.latitude, longitude: second.longitude)
        
        return Int(firstLocation.distance(from: secondLoaction))
    }
}
