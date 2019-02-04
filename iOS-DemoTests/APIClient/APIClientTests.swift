//
//  APIFetchableElementTests.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/1/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest
@testable import iOS_Demo
import Hippolyte
import RxSwift

class APIClientTests: XCTestCase {

    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        NetworkStub.shared.stubRequests()
        NetworkStub.shared.startStub()
    }

    func testFetchUsers() {
        
        let expectation = self.expectation(description: "We should get 3 Users")
        APIClient().fetchElementsFromServer(User.self).subscribe { (event) in
            if let elements = event.element {
                XCTAssertTrue(elements.count == 3)
                expectation.fulfill()
            }
        }.disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchPosts() {
        
        let expectation = self.expectation(description: "We should get 3 Posts")
        APIClient().fetchElementsFromServer(Post.self).subscribe { (event) in
            if let elements = event.element {
                XCTAssertTrue(elements.count == 3)
                expectation.fulfill()
            }
            }.disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchComments() {

        let expectation = self.expectation(description: "We should get 3 Comments")
        APIClient().fetchElementsFromServer(Comment.self).subscribe { (event) in
            if let elements = event.element {
                XCTAssertTrue(elements.count == 3)
                expectation.fulfill()
            }
            }.disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1)
    }

    deinit {
        NetworkStub.shared.stopStub()
    }
}
