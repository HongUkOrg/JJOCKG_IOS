//
//  AlertService.swift
//  letter_mouse
//
//  Created by bleo on 2020/03/09.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func createAlert(_ type: AlertType) -> UIAlertController {
        
        let alertVC = UIAlertController(title: type.title,
                                 message: type.message,
                                 preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        return alertVC
    }
}

enum AlertType {
    case sendLetter(SendLetterError)
    case findLetter(FindLetterError)
}

extension AlertType {
    
    var title: String {
        switch self {
        case .sendLetter:
            return "쪽지 남기기 실패!"
        case .findLetter:
            return "쪽지 찾기 실패!"
        }
    }
    
    var message: String {
        switch self {
        case .sendLetter(let error):
            switch error {
            case .emptyPassword:
                return "암호를 입력해주세요\n 쪽지를 찾을 때 필요합니다"
            case .emptyContent:
                return "내용을 입력해주세요!"
            case .invalidRequestInput:
                return "현재 주소를 찾을 수 없습니다"
            case .networkInavailable:
                return "네트워크 연결을 확인해주세요!"
            }
        case .findLetter(let error):
            switch error {
            case .emptyPassword:
                return "암호를 입력해주세요!"
            case .emptyW3W:
                return "세 단어 주소를 정확히 입력해주세요!"
            case .invalidInput:
                return "알 수 없는 오류"
            case .findFail:
                return "쪽지를 찾을 수 없습니다!\n주소와 암호를 확인해보세요"
            }
        }
    }
}
