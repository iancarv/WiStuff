//
//  Moview.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

struct Movie {
    let data: ApiData
}

extension Movie: MediaItem {
    var artworkUrl: String { return data.artworkUrl100 }
    var description: String { return data.longDescription }
    var previewUrl: String { return data.previewUrl }
    var name: String { return data.trackName }
}
