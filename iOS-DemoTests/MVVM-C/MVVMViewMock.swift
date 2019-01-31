//
//  MVVMViewMock.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
@testable import iOS_Demo

class FakeViewModel: ViewModel { }

class ViewControllerMVVMViewMock: UIViewController, MVVMView {

    var viewModel: FakeViewModel!
        
    var didCallBindViewModel = false
    var didCallViewDidLoad = false
    
    func bindViewModel() {
        self.didCallBindViewModel = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.didCallViewDidLoad = true
    }
}

class ViewMVVMViewMock: UIView, MVVMView {
    
    var viewModel: FakeViewModel!
    
    var didCallBindViewModel = false
    
    func bindViewModel() {
        self.didCallBindViewModel = true
    }
}
