//
//  NavigationTransitionTests.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest
@testable import iOS_Demo

class NavigationTransitionTests: XCTestCase {

    var viewControllerMock: UIViewControllerMock!
    
    override func setUp() {
        viewControllerMock = UIViewControllerMock()
        _ = UINavigationControllerMock(rootViewController: viewControllerMock)
    }

    func testPushNavigationTransition() {
        let navigationTransition = NavigationTransition(.push(UIViewController()))
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.navigationControllerMock().didCallPushViewController)
    }
    
    func testPopNavigationTransition() {
        let navigationTransition = NavigationTransition(.pop)
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.navigationControllerMock().didCallPopViewController)
    }
    
    func testPopToRootNavigationTransition() {
        let navigationTransition = NavigationTransition(.popToRoot)
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.navigationControllerMock().didCallPopToRootViewController)
    }
    
    func testPresentNavigationTransition() {
        let navigationTransition = NavigationTransition(.present(UIViewController()))
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.navigationControllerMock().didCallPresent)
    }
    
    func testDismissNavigationTransition() {
        let navigationTransition = NavigationTransition(.dismiss)
        navigationTransition.execute(from: self.viewControllerMock)
        XCTAssertTrue(self.viewControllerMock.didCallDismiss)
    }
    
    func testNoTransitionTransition() {
        let navigationTransition = NavigationTransition(.noTransition)
        navigationTransition.execute(from: self.viewControllerMock)
        
        XCTAssertFalse(self.viewControllerMock.navigationControllerMock().didCallPushViewController)
        XCTAssertFalse(self.viewControllerMock.navigationControllerMock().didCallPopViewController)
        XCTAssertFalse(self.viewControllerMock.navigationControllerMock().didCallPopToRootViewController)
        XCTAssertFalse(self.viewControllerMock.navigationControllerMock().didCallPresent)
        XCTAssertFalse(self.viewControllerMock.didCallDismiss)
    }
}
