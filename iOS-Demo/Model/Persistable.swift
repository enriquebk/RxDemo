//
//  PesistableObject.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 2/1/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RealmSwift

protocol Persistable {
    static func fetchStoredElements() -> [Self]?
    static func persist(_ elements: [Self])
}

extension Persistable where Self: Object {
    static func fetchStoredElements() -> [Self]? {
        
        do {
            let realm = try Realm()
            let persistedElements = realm.objects(Self.self)
            
            if persistedElements.count > 0 {
                return persistedElements.map { $0 }
            }
        } catch {
            print("Could not access Realm object: ", error)
        }
        
        return nil
    }
    
    static func persist(_ elements: [Self]) {
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(elements)
            }
        } catch {
            print("Could write objects: ", error)
        }
    }
}
