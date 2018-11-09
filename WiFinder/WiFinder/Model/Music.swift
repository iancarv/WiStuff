//
//  Music.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

struct Music {
    let data: ApiData
}

extension Music: MediaItem {
    var artworkUrl: String { return data.artworkUrl100 }
    var description: String { return data.artistName }
    var previewUrl: String { return data.previewUrl }
    var name: String { return data.trackName }
}
