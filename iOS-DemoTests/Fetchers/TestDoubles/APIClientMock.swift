//
//  APIClientMock.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/3/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RxSwift
@testable import iOS_Demo

class APIClientMock: APIClient {

    var didFetchAllUsers = false
    var didFetchAllComments = false
    var didFetchAllPosts = false
    
    override init() {
        super.init()
        NetworkStub.shared.stubRequests()
        NetworkStub.shared.startStub()
    }
    
    override func fetchElementsFromServer<Element>(_ type: Element.Type) -> Observable<[Element]>
        where Element: APIFetchableElement {

            return super.fetchElementsFromServer(type).do(onNext: { [weak self] (_) in
                if self?.didFetchAllUsers == false {
                    self?.didFetchAllUsers = type == User.self
                }
                if self?.didFetchAllPosts == false {
                    self?.didFetchAllPosts = type == Post.self
                }
                if self?.didFetchAllComments == false {
                    self?.didFetchAllComments = type == Comment.self
                }
            })
    }
    
    deinit {
        NetworkStub.shared.stopStub()
    }
}
