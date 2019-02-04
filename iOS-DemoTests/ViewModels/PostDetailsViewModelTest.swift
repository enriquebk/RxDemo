//
//  PostDetailsViewModelTest.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/4/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest
import RxSwift
@testable import iOS_Demo

class PostDetailsViewModelTest: XCTestCase {

    private let disposeBag = DisposeBag()
    private var viewModel: PostDetailsViewModel!
    private let modelFetcher =  ModelFetcherStub()
    
    override func setUp() {
        let post = modelFetcher.postsFromJSON()[0]
        viewModel = PostDetailsViewModel(post: post)
        viewModel.modelFetcher = modelFetcher
    }

    func testScreenName() {
        
        viewModel.screenName.subscribe(onNext: { name in
            XCTAssertEqual(name, L10n.detailsScreenName)
        }).disposed(by: disposeBag)
    }
    
    func testPostDetails() {
        
        viewModel.postDetails.subscribe(onNext: { post in
            XCTAssertEqual(post.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
            XCTAssertEqual(post.body, "quia et suscipit\nsuscipit recusandae consequuntur")
        }).disposed(by: disposeBag)
    }
    
    func testCommentsCount() {
        
        viewModel.commentsCount.subscribe(onNext: { commentsCount in
            XCTAssertTrue(commentsCount == 3)
        }).disposed(by: disposeBag)
    }
    
    func testAuthorName() {
        
        viewModel.author.subscribe(onNext: { user in
            XCTAssertEqual(user.name, "Leanne Graham")
        }).disposed(by: disposeBag)
    }
}
