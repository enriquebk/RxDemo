//
//  PostsRoute.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit

enum PostsRoute: Route {
    func getTransition() -> Transition {
        return NavigationTransition(.noTransition)
    }
}
