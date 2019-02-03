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
        
        if let usersRequest = APIRequest.users.request(),
            let commentsRequest = APIRequest.comments.request(),
            let postsRequest = APIRequest.posts.request() {
            self.stub(request: usersRequest, withFileContent: "users")
            self.stub(request: commentsRequest, withFileContent: "comments")
            self.stub(request: postsRequest, withFileContent: "posts")
        }
        
        self.startStub()
    }
    
    func stub(request: URLRequest, withFileContent filename: String) {
        let bundle = Bundle(for: type(of: self))
        guard let fileURL = bundle.url(forResource: filename, withExtension: "json") else {
            XCTFail("Missing file: \(filename).json")
            return
        }
        
        do {
            if let method = request.method,
                let requestURL = request.url {
                
                var stub = StubRequest(method: method, url: requestURL)
                var response = StubResponse()
                let body = try Data(contentsOf: fileURL)
                response.body = body
                stub.response = response
                Hippolyte.shared.add(stubbedRequest: stub)

            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func startStub() {
        if Hippolyte.shared.isStarted == false {
            Hippolyte.shared.start()
        }
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

}
