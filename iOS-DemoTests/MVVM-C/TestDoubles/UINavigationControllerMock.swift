//
//  UINavigationControllerMock.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit

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
