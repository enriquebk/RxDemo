//
//  PostsViewModelTests.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/3/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest
import RxSwift
@testable import iOS_Demo

class PostsViewModelTests: XCTestCase {

    let disposeBag = DisposeBag()
    let viewModel = PostsViewModel()
    
    let cooridnator = PostsViewModelCoordinatorMock()
    
    override func setUp() {
        viewModel.objectFetcher = ModelFetcherStub()
        viewModel.coordinator = cooridnator
    }
    
    func testScreenName() {

        viewModel.screenName.subscribe(onNext: { name in
            XCTAssertEqual(name, L10n.postsScreenName)
        }).disposed(by: disposeBag)
    }
    
    func testShouldLoadWhenFetchigPosts() {
        
        var isLoading = false
        
        let startLoadingExpectation = self.expectation(description: "Should start loading")
        startLoadingExpectation.expectedFulfillmentCount = 1
        let stopLoadingExpectation = self.expectation(description: "Should stop loading")
        stopLoadingExpectation.expectedFulfillmentCount = 1
        
        viewModel.loading.subscribe(onNext: { loading in
           
            if !isLoading && loading {
                startLoadingExpectation.fulfill()
            }
            
            if isLoading && !loading {
                stopLoadingExpectation.fulfill()
            }
            
            isLoading = loading
        }).disposed(by: disposeBag)
        
        viewModel.loadPosts().subscribe().disposed(by: disposeBag)
        
        wait(for: [startLoadingExpectation, stopLoadingExpectation], timeout: 1)
    }
    
    func testNavigationToDetailsScreen() {

        viewModel.loadPosts().subscribe().disposed(by: disposeBag)
        viewModel.showPost(at: 0)
        
        XCTAssertTrue(cooridnator.didCallNavigateToDetails)
    }
    
    func testAllPostsObserver() {

        let allPostsShouldLoadNewPostsExpectation = self.expectation(description: "All Post observer should emit posts")

        viewModel.allPosts.subscribe { posts in
            if let allPosts = posts.element, allPosts.count > 0 {
                allPostsShouldLoadNewPostsExpectation.fulfill()
            }
        }.disposed(by: disposeBag)
        
        viewModel.loadPosts().subscribe().disposed(by: disposeBag)
        
        wait(for: [allPostsShouldLoadNewPostsExpectation], timeout: 1)
        
    }
}
