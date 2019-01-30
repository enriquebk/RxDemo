//
//  iOS_DemoUITests.swift
//  iOS-DemoUITests
//
//  Created by Enrique Bermúdez on 1/30/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest

class iOS_DemoUITests: XCTestCase {

    override func setUp() {

        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
