//
//  FetchElement.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 2/1/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

protocol APIFetchableElement: Decodable {
    static func fetchRequest() -> APIRequest
}

extension User: APIFetchableElement {
    static func fetchRequest() -> APIRequest {
        return .users
    }
}

extension Post: APIFetchableElement {
    static func fetchRequest() -> APIRequest {
        return .posts
    }
}

extension Comment: APIFetchableElement {
    static func fetchRequest() -> APIRequest {
        return .comments
    }
}
