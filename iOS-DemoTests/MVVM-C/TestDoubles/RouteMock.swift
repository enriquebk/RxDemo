//
//  RouteMock.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 1/31/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

@testable import iOS_Demo

class RouteMock: Route {
    var didCallGetTransition = false
    var returnedTransition: TransitionMock?
    
    func getTransition() -> Transition {
        didCallGetTransition = true
        let transition = TransitionMock()
        returnedTransition = transition
        return transition
    }
}
