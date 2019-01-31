//
//  User.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class User: Object {

    @objc dynamic var userId: Int64 = 0
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var address = Address()
    @objc dynamic var company = Company()
    
}

class Address: Object {

    @objc dynamic var street: String = ""
    @objc dynamic var suite: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var zipcode: String = ""
    @objc dynamic var location = Location()
    
}

class Location: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
}

class Company: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var catchPhrase: String = ""
    @objc dynamic var companyBS: String = ""
}
