//
//  W3WService.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/26.
//  Copyright © 2020 mac. All rights reserved.
//

import RxRelay
import RxSwift

class W3WStore {
    
    static let sharedInstance: W3WStore = W3WStore()
    
    let w3w: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    init() {
        
    }
}
