//
//  FakeViewModelCoordinator.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
@testable import iOS_Demo

class FakeRoute: Route {
    func getTransition() -> Transition {
        return NavigationTransition(.noTransition)
    }
}

class FakeViewModelCoordinator: ViewModel, CoordinatorManager {
    
    var coordinator: Coordinator<FakeRoute>!
}

class FakeViewController: UIViewController, MVVMView  {
    var viewModel: FakeViewModelCoordinator!
    
    func bindViewModel() { }
}
