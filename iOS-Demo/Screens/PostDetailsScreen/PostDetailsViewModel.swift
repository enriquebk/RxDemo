//
//  PostDetailsViewModel.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RxSwift

class PostDetailsViewModel: ViewModel, CoordinatorManager {
    
    var coordinator: Coordinator<PostDetailsRoute>!
    var modelFetcher = ModelFetcher()
    
    let post: Observable<Post>
    let author: Observable<User>
    let commentsCount: Observable<Int>
    
    init(post: Post) {
        self.post = Observable<Post>.just(post)
        self.author = modelFetcher.fetchElements(User.self).map({ users -> User in
            for user in users where user.id == post.userId {
                return user
            }
            return User()
        })
        self.commentsCount = modelFetcher.fetchElements(Comment.self).map({ comments -> Int in
            return comments.filter({ $0.postId == post.id }).count
        })
    }
    
    var screenName: Observable<String> {
        return Observable.just(L10n.detailsScreenName).single()
    }
}
