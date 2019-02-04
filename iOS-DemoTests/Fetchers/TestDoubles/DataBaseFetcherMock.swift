//
//  DataBaseFetcherMock.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/3/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
import XCTest
@testable import iOS_Demo

class DataBaseFetcherMock: DataBaseFetcher {

    var objectPersisted = false

    var didCallPersistMethod = false
    
    override func persist<Element>(_ elements: [Element]) -> Completable where Element: Object {
        
        return Completable.create(subscribe: { [weak self](completable) -> Disposable in
            self?.didCallPersistMethod = true
            completable(.completed)
            return Disposables.create()
        })
    }
    
    override func fetchStoredElements<Element>() -> Observable<[Element]> where Element: Object {
        
        if objectPersisted {
            return Observable<[Element]>.just([Element()])
        }
        
        return Observable.empty()
    }
}
