//
//  ApiMock.swift
//  WiFinderTests
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation
import RxSwift
@testable import WiFinder


class ApiClientMock {
    func send<T: ApiDataProtocol>() -> Observable<[T]> {
        return Observable<[T]>.create { observer in
            let result: [T] = MockFactory.create()
            observer.onNext(result)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}


class MockFactory {
    static func create<T: ApiDataProtocol>() -> [T] {
        var jsonString = ""
        if T.self == Movie.self {
            jsonString = Mocks.movie
        } else if T.self == TvShow.self {
            jsonString = Mocks.tvShow
        } else {
            jsonString = Mocks.music
        }
        
        let json = jsonString.data(using: .utf8)!
        let data: ApiResult = try! JSONDecoder().decode(ApiResult.self, from: json)
        let result: [T] = data.results.map { T.init(data: $0) }
        return result
    }
}
