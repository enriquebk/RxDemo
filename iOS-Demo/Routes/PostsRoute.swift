//
//  PostsRoute.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit

enum PostsRoute: Route {
    
    case details(Post)
    
    func getTransition() -> Transition {
        switch self {
        case let .details(post):
            
            let viewModel = PostDetailsViewModel(post: post)
            let postDetails = PostDetailsViewController.instantiate(with: viewModel)
            
            return NavigationTransition(.push(postDetails))
        }
    }
}
