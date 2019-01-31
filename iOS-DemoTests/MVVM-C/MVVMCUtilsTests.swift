//
//  MVVMCUtilsTests.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest
@testable import iOS_Demo

class MVVMCUtilsTests: XCTestCase {

    func testMVVMCInstantiateMethod() {
        let viewController = FakeViewController.instantiate(with: FakeViewModelCoordinator())
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.viewModel.coordinator)
    }
}
