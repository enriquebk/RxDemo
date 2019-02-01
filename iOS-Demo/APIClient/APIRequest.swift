//
//  APIRoute.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 2/1/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import Foundation

enum APIRequest {

    case posts
    case users
    case comments
    
    private func httpProtocol() -> String {
        return "http"
    }
    
    private func basePath() -> String {
        return "jsonplaceholder.typicode.com"
    }
    
    private func path() -> String {
        switch self {
        case .posts:
            return "/posts"
        case .users:
            return "/users"
        case .comments:
            return "/comments"
        }
    }
    
    private func method() -> String {
        switch self {
        default:
            return "GET"
        }
    }
    
    private func url() -> URL? {
        return URL(string: "\(self.httpProtocol())://\(self.basePath())\(self.path())")
    }
    
    func request() -> URLRequest? {
        if let url = self.url() {
            var request: URLRequest = URLRequest(url: url)
            request.httpMethod = self.method()
            return request
        }
        return nil
    }
}
