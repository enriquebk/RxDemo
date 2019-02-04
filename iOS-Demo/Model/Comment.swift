//
//  Comment.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RealmSwift

final class Comment: Object, Decodable {

    @objc dynamic var id: Int64 = 0
    @objc dynamic var postId: Int64 = 0
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var body: String = ""
}
