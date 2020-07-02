//
//  ReusableView.swift
//  SwiftAlgorithmsSecret
//
//  Created by Nischal Hada on 21/4/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UICollectionViewCell: ReusableView {}
