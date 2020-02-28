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
    
    func sendLetter(request: SendLetterRequest) -> Single<String> {
        
        return provider.rx
            .request(.sendLetter(request))
            .filterSuccessfulStatusCodes()
            .map { $0.data.description }
            .do(onSuccess: { (response) in
                Logger.debug("SendLetter Response : \(response)")
            }, onError: { (error) in
                Logger.info("SendLetter Error\(error)")
            })
    }
    
    func findLetter(request: FindLetterRequest) -> Single<FindLetterResponse> {
        
        Logger.debug("request : \(request)")
        return provider.rx
            .request(.findLetter(request))
            .filterSuccessfulStatusCodes()
            .map(FindLetterResponse.self, using: JSONDecoder())
            .do(onSuccess: { (response) in
                Logger.debug("FindLetter Response : \(response)")
            }, onError: { (error) in
                Logger.info("FindLetter Error\(error)")
            })
    }
}
