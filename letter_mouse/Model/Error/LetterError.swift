//
//  SendLetterError.swift
//  letter_mouse
//
//  Created by bleo on 2020/03/09.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum SendLetterError: Error {
    case emptyPassword
    case emptyContent
    case invalidRequestInput
    case networkInavailable
}

enum FindLetterError: Error {
    case emptyPassword
    case emptyW3W
    case invalidInput
    case findFail
}
