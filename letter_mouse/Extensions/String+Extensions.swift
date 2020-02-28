//
//  String+Extensions.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/22.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

extension String {
    
    func removeSwiftLineBreak() -> String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }
}
