//
//  FindLetterRequest.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/29.
//  Copyright © 2020 mac. All rights reserved.
//

struct FindLetterRequest: Codable {
    var title: String?
    var receiver_phone: String
    var w3w_address: String
    
    init(receiver_phone: String, w3w_address: String) {
        self.receiver_phone = receiver_phone
        self.w3w_address = w3w_address
    }
}

