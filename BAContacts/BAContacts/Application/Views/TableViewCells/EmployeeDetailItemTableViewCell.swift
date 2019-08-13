//
//  EmployeeDetailItemTableViewCell.swift
//  Contacts
//
//  Created by Burak Akyalcin on 29.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

class EmployeeDetailItemTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var projectsLabel: UILabel!
    
    func setCell(with model: Employee) {
        emailLabel.text = model.contactDetails?.email ?? "-"
        phoneLabel.text = model.contactDetails?.phone ?? "-"
        positionLabel.text = model.position ?? "-"
        projectsLabel.text = model.projects?.joined(separator: "\n") ?? "-"
    }
    
}
