//
//  UICollectionViewCell+Contacts.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

public extension UICollectionViewCell {
    // MARK: - Static Methods
    static func registerSelf(_ collectionView: UICollectionView?) {
        let nib = UINib(nibName: self.className, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: self.className)
    }
    
}
