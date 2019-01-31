//
//  TransitionMock.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

@testable import iOS_Demo

class TransitionMock: Transition {
    var from: Presentable?
    
    func execute(from presentable: Presentable) {
        from = presentable
    }
}
