//
//  ApiResult.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

struct ApiResult: Codable  {
    let resultCount: Int
    let results: [ApiData]
}

