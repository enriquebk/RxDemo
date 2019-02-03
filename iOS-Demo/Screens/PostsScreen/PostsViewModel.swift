//
//  PostsViewModel.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RxSwift

class PostsViewModel: ViewModel, CoordinatorManager {
    
    var coordinator: Coordinator<PostsRoute>!
    var objectFetcher = ModelFetcher()
    
    private let disposeBag = DisposeBag()
    private var loadingSubject = BehaviorSubject<Bool>(value: false)
    private var postsSubject = BehaviorSubject<[Post]>(value: [])

    var screenName: Observable<String> {
        return Observable.just(L10n.postsScreenName).single()
    }

    var loading: Observable<Bool> {
        return loadingSubject
    }
    
    var allPosts: Observable<[Post]> {
        return postsSubject
    }
    
    func loadPosts() -> Completable {
    
        return Completable.create { [weak self] completable -> Disposable in
            
            self?.loadingSubject.onNext(true)

            return ModelFetcher().fetchElements(Post.self).subscribe(onNext: { posts in
                self?.postsSubject.onNext(posts)
            }, onError: { error in
                self?.loadingSubject.onNext(false)
                completable(.error((error)))
            }, onCompleted: {
                self?.loadingSubject.onNext(false)
                completable(.completed)
            })
        }
    }
    
    func showPost(at index: Int) {
        do {
            let post = try self.postsSubject.value()[index]
            self.coordinator.navigate(to: .details(post))
        } catch {
            print(error)
        }
    }
}
