//
//  FindLetterResponse.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/29.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct LetterResponse: Decodable {
    
    var title: String?
    var message: String
    var latitude: String
    var longitude: String
    var time_lock: String?
}

struct FindLetterResponse: Decodable {
    
    var letter: [LetterResponse]
}
