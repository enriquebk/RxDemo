//
//  ObjectManager.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 2/3/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class ModelFetcher {
    
    var dataBaseFetcher = DataBaseFetcher()
    var apiClient = APIClient()
    
    func fetchElements<Element: Object>(_ type: Element.Type) -> Observable<[Element]>
        where Element: APIFetchableElement {
    
        return self.dataBaseFetcher
            .fetchStoredElements()
            .ifEmpty(switchTo:
                self.downloadElementsFromServer()
                    .flatMap({ [weak self] (objects) -> Observable<[Object]> in
                        
                        guard let strongSelf = self else { return Observable.empty()}
                        return strongSelf.dataBaseFetcher.persist(objects)
                            .subscribeOn(MainScheduler())
                            .andThen(Observable.just(objects))
                    })
                    .map({ $0.compactMap({ $0 as? Element })
            }))
    }
    
    private func downloadElementsFromServer() -> Observable<[Object]> {
       
        let downloadPosts = self.apiClient.fetchElementsFromServer(Post.self)
        let downloadUsers = self.apiClient.fetchElementsFromServer(User.self)
        let downloadComments = self.apiClient.fetchElementsFromServer(Comment.self)
        
        return Observable.zip(downloadPosts, downloadUsers, downloadComments).map({ (posts, users, comments)  in
            
            var elements = [Object]()
            elements.append(contentsOf: posts)
            elements.append(contentsOf: users)
            elements.append(contentsOf: comments)
            
            return elements
        })
    }
}
