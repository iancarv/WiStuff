//
//  ModelTests.swift
//  WiFinderTests
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import XCTest
@testable import WiFinder

class ModelTests: XCTestCase {
    var apiData: ApiData!
    override func setUp() {
        super.setUp()
        apiData = ApiData(artworkUrl100: "https://is5-ssl.mzstatic.com/image/thumb/Music/v4/19/32/e5/1932e5d6-0ec5-0237-6be9-f6fffd80e85c/source/100x100bb.jpg", artistName: "Jack Johnson", trackName: "Better Together", longDescription: "", previewUrl: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music6/v4/13/22/67/1322678b-e40d-fb4d-8d9b-3268fe03b000/mzaf_8818596367816221008.plus.aac.p.m4a")
    }
    
    override func tearDown() {
        apiData = nil
        super.tearDown()
    }
    
    func testMovieModel() {
        let model = Movie(data: apiData)
        
        XCTAssertEqual(model.artworkUrl, apiData.artworkUrl100,
               "Model artworkUrl not consistent with ApiData")
        XCTAssertEqual(model.previewUrl, apiData.previewUrl,
               "Model previewUrl not consistent with ApiData")
        XCTAssertEqual(model.description, apiData.longDescription,
               "Movie 'description' should be consistent with ApiData 'longDescription'")
        XCTAssertEqual(model.name, apiData.trackName,
               "Movie 'name' should be consistent with ApiData 'trackName'")
    }
    
    func testTvShowModel() {
        let model = TvShow(data: apiData)
        
        XCTAssertEqual(model.artworkUrl, apiData.artworkUrl100,
               "Model artworkUrl not consistent with ApiData")
        XCTAssertEqual(model.previewUrl, apiData.previewUrl,
               "Model previewUrl not consistent with ApiData")
        XCTAssertEqual(model.description, apiData.longDescription,
               "TvShow 'description' should be consistent with ApiData 'longDescription'")
        XCTAssertEqual(model.name, apiData.artistName,
               "TvShow 'name' should be consistent with ApiData 'artistName'")
    }
    
    func testMusicModel() {
        let model = Music(data: apiData)
        
        XCTAssertEqual(model.artworkUrl, apiData.artworkUrl100,
               "Model artworkUrl not consistent with ApiData")
        XCTAssertEqual(model.previewUrl, apiData.previewUrl,
               "Model previewUrl not consistent with ApiData")
        XCTAssertEqual(model.description, apiData.artistName,
               "Music 'description' should be consistent with ApiData 'artistName'")
        XCTAssertEqual(model.name, apiData.trackName,
               "Music 'name' should be consistent with ApiData 'trackName'")
    }
}
