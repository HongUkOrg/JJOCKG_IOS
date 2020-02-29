//
//  JGServicdes.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Moya

protocol JGServicesProtocol {
    
    // MARK: Services
    var apiService: JGApiService { get }
    var letterService: LetterServiceType { get }
}
class JGServices: JGServicesProtocol {
    
    // MARK: Services
    let apiService: JGApiService
    let letterService: LetterServiceType
    
    init() {
        self.apiService = JGApiService(provider: MoyaProvider<JGEndPoint>())
        self.letterService = LetterService()
    }
}
