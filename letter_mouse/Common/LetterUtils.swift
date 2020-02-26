//
//  LetterUtils.swift
//  letter_mouse
//
//  Created by mac on 09/06/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class LetterUtils: NSObject {
    
    static func convertToDictionary(_ text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
