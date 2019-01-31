//
//  MVVMView.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit

protocol ViewModel: class { }

protocol MVVMView: class {
    associatedtype ViewModelType: ViewModel

    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension MVVMView where Self: UIViewController {
    
    func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension MVVMView where Self: UIView {
    
    func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
