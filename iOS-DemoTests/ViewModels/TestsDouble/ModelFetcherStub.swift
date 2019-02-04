//
//  ModelFetcherStub.swift
//  iOS-DemoTests
//
//  Created by Enrique Bermúdez on 2/3/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
@testable import iOS_Demo

class ModelFetcherStub: ModelFetcher {

    override func fetchElements<Element>(_ type: Element.Type) -> Observable<[Element]>
        where Element: Object, Element: APIFetchableElement {
        return Observable.just([Element()])
    }
}
