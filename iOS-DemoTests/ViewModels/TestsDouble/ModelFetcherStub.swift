//
//  ModelFetcherStub.swift
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

class ModelFetcherStub: ModelFetcher {

    override func fetchElements<Element>(_ type: Element.Type) -> Observable<[Element]>
        where Element: Object, Element: APIFetchableElement {
            
            let elements: [Element]!
            
            if type == User.self {
                elements = self.usersFromJSON() as? [Element]
            } else if type == Post.self {
                elements = self.postsFromJSON() as? [Element]
            } else {
                elements = self.commentsFromJSON() as? [Element]
            }
            
        return Observable.just(elements)
    }
}

extension ModelFetcherStub {
    public func postsFromJSON() -> [Post] {
        
        let bundle = Bundle(for: type(of: self))
        guard let fileURL = bundle.url(forResource: "posts", withExtension: "json") else {
            XCTFail("Missing file: posts.json")
            return []
        }
        
        do {
            let data = try Data.init(contentsOf: fileURL)
            let elements =  try JSONDecoder().decode([Post].self, from: data)
            return elements
        } catch {
            XCTFail(error.localizedDescription)
        }
        return []
    }
    
    public func usersFromJSON() -> [User] {
        
        let bundle = Bundle(for: type(of: self))
        guard let fileURL = bundle.url(forResource: "users", withExtension: "json") else {
            XCTFail("Missing file: users.json")
            return []
        }
        
        do {
            let data = try Data.init(contentsOf: fileURL)
            let elements =  try JSONDecoder().decode([User].self, from: data)
            return elements
        } catch {
            XCTFail(error.localizedDescription)
        }
        return []
    }
    
    public func commentsFromJSON() -> [Comment] {
        
        let bundle = Bundle(for: type(of: self))
        guard let fileURL = bundle.url(forResource: "comments", withExtension: "json") else {
            XCTFail("Missing file: comments.json")
            return []
        }
        
        do {
            let data = try Data.init(contentsOf: fileURL)
            let elements =  try JSONDecoder().decode([Comment].self, from: data)
            return elements
        } catch {
            XCTFail(error.localizedDescription)
        }
        return []
    }
}
