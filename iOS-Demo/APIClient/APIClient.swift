//
//  APIClient.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 2/1/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class APIClient: NSObject {
    
    func execute(request apiRequest: APIRequest) -> Observable<Data> {
        guard let request = apiRequest.request() else {
            print("Invalid request")
            return Observable.just(Data())
        }
        
        return URLSession.shared.rx.data(request: request)
    }
    
    func fetchElementsFromServer<Element>(_ type: Element.Type) -> Observable<[Element]>
        where Element: APIFetchableElement {
            
            return self.execute(request: Element.fetchRequest()).map({
                do {
                    let elements =  try JSONDecoder().decode([Element].self, from: $0)
                    return elements
                } catch {
                    throw error
                }
            })
    }
}
