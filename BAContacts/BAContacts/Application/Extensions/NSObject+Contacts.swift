//
//  NSObject+Contacts.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

public extension NSObject {
    // MARK: - Static Properties
    @objc class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
