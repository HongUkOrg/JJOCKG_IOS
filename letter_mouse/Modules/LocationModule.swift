//
//  LocationModule.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import CoreLocation
import RxRelay

protocol LocationModuleProtocol {
    
    var locationRelay: BehaviorRelay<LocationModel?> { get }
}

class LocationModule: NSObject, LocationModuleProtocol {
    
    // MARK: Properties
    let locationManager: CLLocationManager = CLLocationManager()
    var locationRelay: BehaviorRelay<LocationModel?> = BehaviorRelay<LocationModel?>(value: nil)

    // MARK: Initialize
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        } else {
            Logger.error("Can't access location")
        }
    }
    
}

extension LocationModule: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
//        Logger.verbose("current location Module : \(latitude), \(longitude)")
        locationRelay.accept(LocationModel(latitude: latitude, longitude: longitude))
    }
}

struct LocationModel {
    var latitude: Double
    var longitude: Double
}
