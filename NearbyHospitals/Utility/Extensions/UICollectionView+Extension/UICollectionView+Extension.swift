//
//  UICollectionView+Extension.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(UINib(nibName: String(describing: T.nibName), bundle: nil), forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
        else { fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)") }
        return cell
    }

    func cellForItem<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = cellForItem(at: indexPath) as? T
        else { fatalError("Could not get cell: \(T.self)") }
        return cell
    }
}
