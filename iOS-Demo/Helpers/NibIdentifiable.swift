//
//  NibIdentifiable.swift
//  iOS-Demo
//
//  Created by Enrique Bermúdez on 2/2/19.
//  Copyright © 2019 Enrique Bermudez. All rights reserved.
//

import Foundation
import UIKit

protocol NibIdentifiable {
    static var nibIdentifier: String { get }
}

extension NibIdentifiable {
    static var nib: UINib {
        return UINib(nibName: nibIdentifier, bundle: nil)
    }
}

extension UIView: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {

    func registerCell<T: UITableViewCell>(type: T.Type) {
        register(type.nib, forCellReuseIdentifier: String(describing: T.self))
    }
}
