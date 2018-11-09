//
//  ApiClient.swift
//  WiFinder
//
//  Created by Ian Carvalho on 07/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation
import RxSwift

class ApiClient {
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    func send(apiRequest: ApiRequest) -> Observable<ApiResult> {
        return Observable<ApiResult>.create { observer in
            let request = apiRequest.request(with: self.baseURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let result: ApiResult = try JSONDecoder().decode(ApiResult.self, from: data ?? Data())
                    observer.onNext(result)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
