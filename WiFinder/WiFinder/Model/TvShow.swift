//
//  TvShow.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

struct TvShow {
    let data: ApiData
}

extension TvShow: MediaItem {
    var artworkUrl: String { return data.artworkUrl100 }
    var description: String { return data.longDescription }
    var previewUrl: String { return data.previewUrl }
    var name: String { return data.artistName }
}

