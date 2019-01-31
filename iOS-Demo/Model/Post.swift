//
//  Post.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import Foundation
import RealmSwift

class Post: Object {

    @objc dynamic var postId: Int64 = 0
    @objc dynamic var userId: Int64 = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
}
