//
//  ModelFetcherTests.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/3/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest
import RxSwift
@testable import iOS_Demo

class ModelFetcherTests: XCTestCase {

    private let disposeBag = DisposeBag()
    private let modelFetcher = ModelFetcher()
    private let databaseMock = DataBaseFetcherMock()
    private let apiClientMock = APIClientMock()
    
    override func setUp() {
        modelFetcher.dataBaseFetcher = databaseMock
        modelFetcher.apiClient = apiClientMock
    }
    
    func testDownloadAllElementsWhenObjectAreNotPersisted() {
        
        databaseMock.objectPersisted = false
        
        let expectation = self.expectation(description: "Download elements from server")
        
        modelFetcher.fetchElements(Post.self)
            .subscribe(onCompleted: { [weak self] in
                guard let wself = self else { return }
                XCTAssertTrue(wself.apiClientMock.didFetchAllComments)
                XCTAssertTrue(wself.apiClientMock.didFetchAllPosts)
            	XCTAssertTrue(wself.apiClientMock.didFetchAllUsers)
                expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testElementsShouldNotBeDownloadedWhenObjectArePersisted() {
        
        databaseMock.objectPersisted = true
        
        let expectation = self.expectation(description: "Fetch elements from database")
        
        modelFetcher.fetchElements(Post.self)
            .subscribe(
            onCompleted: { [weak self] in
                guard let wself = self else { return }
                XCTAssertTrue(wself.apiClientMock.didFetchAllComments == false)
                XCTAssertTrue(wself.apiClientMock.didFetchAllPosts == false)
                XCTAssertTrue(wself.apiClientMock.didFetchAllUsers == false)
                expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testShouldFetchModel() {
        
        let expectation = self.expectation(description: "ModelFetcher should fetch elements")
        
        modelFetcher.fetchElements(Post.self)
            .subscribe(onNext: { posts in
                XCTAssertTrue(posts.count > 0)
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testShouldPersitModelAfterDownloadIt() {
        
        databaseMock.objectPersisted = false
        
        let expectation = self.expectation(description: "Should persit model after download")
        
        modelFetcher.fetchElements(Post.self)
            .subscribe(
                onCompleted: { [weak self] in
                    guard let wself = self else { return }
                    XCTAssertTrue(wself.databaseMock.didCallPersistMethod)
                    expectation.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testShouldNotPersitModelIfItWasDownloaded() {
        
        databaseMock.objectPersisted = true

        let expectation = self.expectation(description: "Should not persit model if it was downloaded")
        
        modelFetcher.fetchElements(Post.self)
            .subscribe(
                onCompleted: { [weak self] in
                    guard let wself = self else { return }
                    XCTAssertTrue(wself.databaseMock.didCallPersistMethod == false)
                    expectation.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
    }
}
