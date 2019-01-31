//
//  MVVMViewTests.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest
@testable import iOS_Demo

class MVVMViewTests: XCTestCase {

    let fakeViewModel = FakeViewModel()
    
    func testUIViewBinding() {
       
        let view = ViewMVVMViewMock()
        
        view.bind(to: fakeViewModel)
        
        XCTAssertTrue(view.didCallBindViewModel)
        XCTAssertNotNil(view.viewModel)
    }
    
    func testUIViewControllerBinding() {
        
        let viewController = ViewControllerMVVMViewMock()

        viewController.bind(to: fakeViewModel)
        
        XCTAssertTrue(viewController.didCallBindViewModel)
        XCTAssertTrue(viewController.didCallViewDidLoad)
        XCTAssertNotNil(viewController.viewModel)
    }
}
