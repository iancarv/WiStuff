//
//  QueryRequest.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

class QueryRequest: ApiRequest {
    var parameters: [String : String]
    init(query: Query) {
        parameters = [
            "term": query.term,
            "media": query.media.rawValue
        ]
    }
}
