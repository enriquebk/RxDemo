//
//  APIRequestTests.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/1/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest
@testable import iOS_Demo

class APIRequestTests: XCTestCase {

    func testPostsRequest() {
        
        let request = APIRequest.posts.request()
        
        XCTAssertTrue(request?.httpMethod == "GET")
        XCTAssertTrue(request?.url?.absoluteString == "http://jsonplaceholder.typicode.com/posts")
    }
    
    func testUsersRequest() {
        
        let request = APIRequest.users.request()
        
        XCTAssertTrue(request?.httpMethod == "GET")
        XCTAssertTrue(request?.url?.absoluteString == "http://jsonplaceholder.typicode.com/users")
    }
    
    func testCommentsRequest() {
        
        let request = APIRequest.comments.request()
        
        XCTAssertTrue(request?.httpMethod == "GET")
        XCTAssertTrue(request?.url?.absoluteString == "http://jsonplaceholder.typicode.com/comments")
    }
}
