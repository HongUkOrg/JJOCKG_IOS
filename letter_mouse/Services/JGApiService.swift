//
//  JGApiService.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import Moya
import RxSwift

protocol JGApiServiceProtocol {
    
    // MARK: Moya
    var provider: MoyaProvider<JGEndPoint> { get }
    

}

class JGApiService {
    
    let provider: MoyaProvider<JGEndPoint>
    
    init(provider: MoyaProvider<JGEndPoint>) {
        self.provider = provider
    }
    
    // MARK: API Call
    func getW3W(location: LocationModel) -> Single<What3WordsResponse> {
        
        let requestString = "\(location.latitude),\(location.longitude)"
        return provider.rx
            .request(.getWhat3Words(requestString))
            .filterSuccessfulStatusCodes()
            .map(What3WordsResponse.self, using: JSONDecoder())
            .do(onSuccess: { (response) in
//                Logger.info("response : \(response)")
            }, onError: { (error) in
                Logger.info("get w3w error\(error)")
            })
    }
}
