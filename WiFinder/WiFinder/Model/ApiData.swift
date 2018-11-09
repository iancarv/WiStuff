//
//  ApiResponse.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

protocol ApiDataProtocol {
    var data: ApiData { get }
    init(data: ApiData)
}

struct ApiData: Codable  {
    let artworkUrl100: String
    let artistName: String
    let trackName: String
    let longDescription: String
    let previewUrl: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100) ?? ""
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription) ?? ""
        previewUrl = try values.decodeIfPresent(String.self, forKey: .previewUrl) ?? ""
    }
    
    init(artworkUrl100:String, artistName: String,
         trackName: String, longDescription: String,
         previewUrl: String) {
        self.artworkUrl100 = artworkUrl100
        self.artistName = artistName
        self.trackName = trackName
        self.longDescription = longDescription
        self.previewUrl = previewUrl
    }
}

