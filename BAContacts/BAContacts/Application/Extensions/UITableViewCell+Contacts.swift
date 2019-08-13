//
//  UITableViewCell+Contacts.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    
    // MARK: - Static Methods
    static func registerSelf(_ toTableView: UITableView?) {
        let nib = UINib(nibName: self.className, bundle: nil)
        toTableView?.register(nib, forCellReuseIdentifier: self.className)
    }
    
}
