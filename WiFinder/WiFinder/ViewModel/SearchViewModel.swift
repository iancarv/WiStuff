//
//  SearchViewModel.swift
//  WiFinder
//
//  Created by Ian Carvalho on 08/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

class SearchViewMovel {
    private let apiClient = ApiClient()
    var searchDidFinish: Observable<[MediaItem]>?
    let loadingIndicator = ActivityIndicator()
    let searchText = BehaviorRelay<String>(value: "")
    let searchScope = BehaviorRelay<MediaType>(value: .movie)
    let searchScopeIndex = BehaviorRelay<Int>(value: 0)
    let updateSearch = BehaviorRelay<Bool>(value: false)
    
    init() {
        
        let searchTextChanged  =  searchText.asObservable().skip(1)
        let searchIndexChanged = searchScopeIndex.asObservable()
        
        _ = searchIndexChanged
            .map { MediaType.allValues[$0] }
            .bind(to: searchScope)
        
        let searchChanged = Observable.combineLatest(searchText.asObservable(), searchScope.asObservable())
            .map { (term, media) -> (String, MediaType) in
                print((term, media))
                return (term, media)
        }
        
        let clearSearch = searchTextChanged
            .map { _ -> [MediaItem] in
                return [MediaItem]()
        }
        
        let searchQuery = searchChanged
            .debounce(0.3, scheduler: MainScheduler.instance)
            .map { Query(term: $0, media: $1) }
            .map { QueryRequest(query: $0) }
        

        let searchResult = Observable.combineLatest(searchQuery.asObservable(), searchScope.asObservable())
            .flatMapLatest { (request, mediaType: MediaType) -> Observable<[MediaItem]> in
                let result = self.apiClient
                    .send(apiRequest: request)
                    .trackActivity(self.loadingIndicator)
                    .observeOn(MainScheduler.instance)
                    .map { $0.results }
                    .map({ $0.map { MediaFactory.create(data: $0, mediaType: mediaType) } })
                return result
            }
        

        
        searchDidFinish = Observable.of(searchResult, clearSearch).merge()
    }
}
