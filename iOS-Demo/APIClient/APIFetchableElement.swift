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

protocol APIFetchableElement {
    static func fetchAllElementsFromServer() -> Observable<[Self]>
    static func fetchRequest() -> APIRequest
}

extension APIFetchableElement where Self: Decodable {
    
    static func fetchAllElementsFromServer() -> Observable<[Self]> {
        return APIClient.execute(request: self.fetchRequest()).map({
            do {
                let elements =  try JSONDecoder().decode([Self].self, from: $0)
                return elements
            } catch {
                throw error
            }
        })
    }
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
