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

class DataBaseFetcher {

    func fetchStoredElements<Element: Object>() -> Observable<[Element]> {
        
        do {
            let realm = try Realm()
            let persistedElements = realm.objects(Element.self)
            
            if persistedElements.count > 0 {
                return Observable.just(persistedElements.map { $0 })
            }
        } catch {
            return Observable<[Element]>.error(error)
        }
        
        return Observable.empty()
    }
    
    func persist<Element: Object>(_ elements: [Element]) -> Completable {

        return Completable.create { (completable) -> Disposable in
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(elements)
                    completable(.completed)
                }
            } catch {
                completable(.error((error)))
            }
            return Disposables.create()
        }
    }
}
