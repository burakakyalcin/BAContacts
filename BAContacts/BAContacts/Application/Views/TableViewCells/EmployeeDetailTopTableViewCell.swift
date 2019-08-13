//
//  EmployeeDetailTopTableViewCell.swift
//  Contacts
//
//  Created by Burak Akyalcin on 29.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

class EmployeeDetailTopTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var contactNameLabel: UILabel!
    @IBOutlet private weak var initialLettersView: UIView!
    @IBOutlet private weak var initialLettersLabel: UILabel!
    
    func setCell(with model: Employee) {
        contactNameLabel.text = "\(model.firstName ?? "") \(model.lastName ?? "")"
        initialLettersView.layer.cornerRadius = initialLettersView.frame.width / 2
        initialLettersLabel.text = "\(model.firstName?.prefix(1) ?? "")\(model.lastName?.prefix(1) ?? "")"
        
        let gradientLayer = CAGradientLayer().makeGradient(topColor: #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1), bottomColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        gradientLayer.frame = initialLettersView.bounds
        initialLettersView.layer.insertSublayer(gradientLayer, at: 0)
    }

}
