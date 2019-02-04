//
//  PostsViewModelCoordinator.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/4/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
@testable import iOS_Demo

class PostsViewModelCoordinatorMock: Coordinator<PostsRoute> {

    var didCallNavigateToDetails = false
    
    init() {
        super.init(root: UIViewController())
    }
    
    override func navigate(to destination: PostsRoute) {
        didCallNavigateToDetails = true
    }
}
