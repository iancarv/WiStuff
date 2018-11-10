//
//  ObservableType.swift
//  WiBot
//
//  Created by Ian Carvalho on 09/11/18.
//  Copyright © 2018 Ian. All rights reserved.
//
// From: edited Sep 10 at 17:50

import Foundation
import RxSwift

extension ObservableType {
    
    /**
     Filters the source observable sequence using a trigger observable sequence producing Bool values.
     Elements only go through the filter when the trigger has not completed and its last element was true. If either source or trigger error's, then the source errors.
     - parameter trigger: Triggering event sequence.
     - returns: Filtered observable sequence.
     */
    func filter(if trigger: Observable<Bool>) -> Observable<E> {
        return withLatestFrom(trigger) { (myValue, triggerValue) -> (E, Bool) in
            return (myValue, triggerValue)
            }
            .filter { (myValue, triggerValue) -> Bool in
                return triggerValue == true
            }
            .map { (myValue, triggerValue) -> E in
                return myValue
        }
    }
}
