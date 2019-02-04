//
//  NetworkStub.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/3/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import XCTest
import Hippolyte
@testable import iOS_Demo

class NetworkStub: NSObject {

    static let shared = NetworkStub()
    
    func stubRequests() {
        if let usersRequest = APIRequest.users.request(),
            let commentsRequest = APIRequest.comments.request(),
            let postsRequest = APIRequest.posts.request() {
            self.stub(request: usersRequest, withFileContent: "users")
            self.stub(request: commentsRequest, withFileContent: "comments")
            self.stub(request: postsRequest, withFileContent: "posts")
        }
    }
    
    func stub(request: URLRequest, withFileContent filename: String) {
        
        guard Hippolyte.shared.isStarted == false else {
            return
        }
        
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
    
    func stopStub() {
        Hippolyte.shared.stop()
    }
}
