//
//  ApiTests.swift
//  WiFinderTests
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import XCTest
import RxBlocking
@testable import WiFinder

class ApiTests: XCTestCase {
    var apiClient: ApiClientMock!
    
    override func setUp() {
        super.setUp()
        apiClient = ApiClientMock()
    }
    
    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }
    
    func testQueryRequest() {
        let testCases: [MediaType: Query] = [
            .movie: Query(term: "Fear and Loathing", media: .movie),
            .music: Query(term: "Pink Floyd", media: .music),
            .tvShow: Query(term: "Dr House", media: .tvShow)
        ]
        
        for (_, query) in testCases {
            let request = QueryRequest(query: query)
            XCTAssertEqual(request.parameters["term"], query.term)
            XCTAssertEqual(request.parameters["media"], query.media.rawValue)
        }
    }
    
    func testMovieRequest() {
        let results: [Movie] = try! apiClient.send().toBlocking().first()!
        let result = results[0]
        XCTAssertEqual(result.artworkUrl, "https://is3-ssl.mzstatic.com/image/thumb/Video/v4/27/68/a6/2768a6e7-a03d-4d09-8fd1-0530572b1e37/source/100x100bb.jpg")
        XCTAssertEqual(result.previewUrl, "https://video-ssl.itunes.apple.com/apple-assets-us-std-000001/Video128/v4/56/4c/89/564c892f-3265-38f4-5a60-7a80b62d27d8/mzvf_233891005559405433.640x480.h264lc.U.p.m4v")
        XCTAssertEqual(result.description, "When a writing assignment lands journalist Raoul Duke (Johnny Depp) and sidekick Dr. Gonzo (Benicio Del Toro) in Las Vegas, they decide to make it the ultimate business trip. But before long, business is forgotten and trip has become the key word. Fueled by a suitcase full of mind-bending pharmaceuticals, Duke and Gonzo set off on a fast and furious ride through nonstop neon, surreal surroundings and a crew of the craziest characters ever (including cameo appearances by Cameron Diaz, Christina Ricci, Gary Busey and many others). But no matter where misadventure leads them, Duke and Gonzo discover that sometimes going too far is the only way to go.")
        XCTAssertEqual(result.name, "Fear and Loathing In Las Vegas")
    }
    
    func testMusicRequest() {
        let results: [Music] = try! apiClient.send().toBlocking().first()!
        let result = results[0]
        XCTAssertEqual(result.artworkUrl, "https://is1-ssl.mzstatic.com/image/thumb/Music/v4/8b/7d/fa/8b7dfa67-1f72-966b-fa65-2fe79e9df1a1/source/100x100bb.jpg")
        XCTAssertEqual(result.previewUrl, "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music/ef/06/90/mzi.nqevqusj.aac.p.m4a")
        XCTAssertEqual(result.description, "Marina and The Diamonds")
        XCTAssertEqual(result.name, "Fear and Loathing")
    }
    
    func testTvShowRequest() {
        let results: [TvShow] = try! apiClient.send().toBlocking().first()!
        let result = results[0]
        XCTAssertEqual(result.artworkUrl, "https://is2-ssl.mzstatic.com/image/thumb/Video6/v4/18/42/14/1842147b-9de4-6e64-efd0-95c03bdcc95a/source/100x100bb.jpg")
        XCTAssertEqual(result.previewUrl, "https://video-ssl.itunes.apple.com/apple-assets-us-std-000001/Video117/v4/bc/36/ed/bc36ede5-fbbd-2db6-2c58-5109aafa3527/mzvf_2878594021892648331.640x478.h264lc.U.p.m4v")
        XCTAssertEqual(result.description, "With their lives in danger in New Vegas, Monroe and Connor face a difficult decision in order to survive. Back in Willoughby, Miles questions whether he can trust Neville and Jason to help take down the Patriots. Meanwhile, Aaron and Priscilla (guest star MAUREEN SEBASTIAN) find themselves at odds over the nano code.")
        XCTAssertEqual(result.name, "Revolution")
    }
}
