//
//  Query.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

enum MediaType: String {
    case music, tvShow, movie
    
    static let allValues = [movie, tvShow, music]
}

struct Query {
    let term: String
    let media: MediaType
}
