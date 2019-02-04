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

final class User: Object, Decodable {

    @objc dynamic var id: Int64 = 0
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var address: Address?
    @objc dynamic var company: Company?
    
}

class Address: Object, Decodable {

    @objc dynamic var street: String = ""
    @objc dynamic var suite: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var zipcode: String = ""
    @objc dynamic var geo: Location?
    
}

class Location: Object, Decodable {
    @objc private dynamic var lat: String = ""
    @objc private dynamic var lng: String = ""
    
    var coordinate: CLLocationCoordinate2D {
        if let latitude = Double(self.lat), let longitude = Double(self.lng) {
            return CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude)
        }
        return CLLocationCoordinate2D()
    }
}

class Company: Object, Decodable {
    @objc dynamic var name: String = ""
    @objc dynamic var catchPhrase: String = ""
    @objc dynamic var bs: String = ""
}
