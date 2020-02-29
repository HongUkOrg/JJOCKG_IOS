//
//  LetterStep.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/27.
//  Copyright © 2020 mac. All rights reserved.
//

enum LetterStep {
    case normal
    case send
    case find
    case tracking
}

extension LetterStep {
    func titleName() -> String {
        switch self {
        case .normal:
            return "나의 현재 주소"
        case .send:
            return "쪽지 남기기"
        case .find, .tracking:
            return "쪽지 찾기"
        }
    }
}
