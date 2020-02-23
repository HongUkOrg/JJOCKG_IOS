//
//  What3WordsRespons.swift
//  letter_mouse
//
//  Created by bleo on 2020/02/23.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct What3WordsResponse: Codable {

    var words: String
}

/*
"thanks": "Thanks from all of us at filled.count.soap for using a what3words API",
"crs": {
    "type": "link",
    "properties": {
        "href": "http://spatialreference.org/ref/epsg/4326/ogcwkt/",
        "type": "ogcwkt"
    }
},
"words": "유사점.높아지다.당기다",
"bounds": {
    "southwest": {
        "lng": 21.938109,
        "lat": 37.123113
    },
    "northeast": {
        "lng": 21.938143,
        "lat": 37.12314
    }
},
"geometry": {
    "lng": 21.938126,
    "lat": 37.123127
},
"language": "ko",
"map": "https://w3w.co/%EC%9C%A0%EC%82%AC%EC%A0%90.%EB%86%92%EC%95%84%EC%A7%80%EB%8B%A4.%EB%8B%B9%EA%B8%B0%EB%8B%A4",
"status": {
    "reason": "OK",
    "status": 200
}
*/
