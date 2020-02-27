//
//  JGEndPoint.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import Moya

enum JGEndPoint {
    case getWhat3Words(String)
    case sendLetter(SendLetterRequest)
    case findLetter
}

extension JGEndPoint: TargetType {
    
    enum ServerAddress: String {
        case what3Words = "https://api.what3words.com/v2"
        case jgServer = "http://phwysl.dothome.co.kr/v2"
    }
    
    var serverAddress: ServerAddress {
        switch self {
        case .getWhat3Words:
            return .what3Words
        case .sendLetter, .findLetter:
            return .jgServer
        }
    }
    
    var baseURL: URL {
        return URL(string: serverAddress.rawValue)!
    }
    
    var path: String {
        switch self {
        case .getWhat3Words:
            return "/reverse"
        case .sendLetter:
            return "/save_letter.php"
        case .findLetter:
            return "/find_letter.php"
        }
    }
    
    var method: Method {
        switch self {
        case .getWhat3Words:
            return .get
        case .findLetter, .sendLetter:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getWhat3Words(let coordString):
            let encoding = URLEncoding(destination: .queryString, arrayEncoding: .brackets, boolEncoding: .literal)
            return Task.requestParameters(parameters: ["coords": coordString,
                                                       "display": "full",
                                                       "format": "json",
                                                       "key": "KYM3G8LX",
                                                       "lang": "ko"
                ],
                encoding: encoding)
        case .sendLetter(let request):
            return .requestJSONEncodable(request)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
}
