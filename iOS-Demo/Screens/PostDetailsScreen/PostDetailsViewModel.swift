//
//  PostDetailsViewModel.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RxSwift

class PostDetailsViewModel: ViewModel {
    
    var modelFetcher = ModelFetcher()
    
    private var post: Post!
    var postDetails: Observable<Post> {
        return Observable<Post>.just(post)
    }
    
    var author: Observable<User> {
        return modelFetcher.fetchElements(User.self).map({ [weak self] users -> User in
            for user in users where user.id == self?.post.userId {
                return user
            }
            return User()
        })
    }
    
    var commentsCount: Observable<Int> {
        return modelFetcher.fetchElements(Comment.self).map({ [weak self] comments -> Int in
            return comments.filter({ $0.postId == self?.post.id }).count
        })
    }
    
    init(post: Post) {
        self.post = post
    }
    
    var screenName: Observable<String> {
        return Observable.just(L10n.detailsScreenName).single()
    }
}
