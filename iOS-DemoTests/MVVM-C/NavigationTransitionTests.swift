//
//  NavigationTransitionTests.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import XCTest
@testable import iOS_Demo

class UINavigationControllerMock: UINavigationController {
    var didCallPushViewController = false
    var didCallPopViewController = false
    var didCallPopToRootViewController = false
    var didCallPresent = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            self.didCallPushViewController = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        self.didCallPopViewController = true
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        self.didCallPopToRootViewController = true
        return super.popToRootViewController(animated: animated)
    }
    
    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        self.didCallPresent = true
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

class UIViewControllerMock: UIViewController {
    var didCallDismiss = false

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.didCallDismiss = true
        super.dismiss(animated: flag, completion: completion)
    }
    
    func navigationControllerMock() -> UINavigationControllerMock {
        guard let navController = self.navigationController as? UINavigationControllerMock else {
            return UINavigationControllerMock()
        }
        return navController
    }
}

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
