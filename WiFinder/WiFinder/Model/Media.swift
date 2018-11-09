//
//  Media.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

protocol MediaProtocol {
    var artworkUrl: String { get }
    var description: String { get }
    var previewUrl: String { get }
    var name: String { get }
}

protocol MediaItem: MediaProtocol, ApiDataProtocol { }


class MediaFactory {
    static func create(data: ApiData, mediaType: MediaType) -> MediaItem {
        let typeLookup: [MediaType: MediaItem.Type] = [
            .movie: Movie.self,
            .music: Music.self,
            .tvShow: TvShow.self,
        ]
        
        if let T = typeLookup[mediaType] {
            return T.self.init(data: data)
        }
        
        return Movie(data: data)
    }
}
