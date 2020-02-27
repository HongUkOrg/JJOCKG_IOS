//
//  SendLetterRequest.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/27.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct SendLetterRequest: Codable {
    
    var sender_phone: String?
    var title: String?
    var time_lock: String?
    var receiver_phone: String
    var message: String
    var w3w_address: String
    var latitude: Double
    var longitude: Double
    
    init(receiver_phone: String, message: String, w3w_address: String, latitude: Double, longitude: Double) {
        self.receiver_phone = receiver_phone
        self.message = message
        self.w3w_address = w3w_address
        self.latitude = latitude
        self.longitude = longitude
    }
}
