//
//  EmployeeListItemTableViewCell.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

class EmployeeListItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var contactNameLabel: UILabel!
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var initialLettersView: UIView!
    @IBOutlet private weak var initialLettersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(with employee: Employee) {
        contactNameLabel.text = "\(employee.firstName ?? "") \(employee.lastName ?? "")"
        detailImageView.tintColor = #colorLiteral(red: 0, green: 0.4793452024, blue: 0.9990863204, alpha: 1)
        initialLettersView.layer.cornerRadius = initialLettersView.frame.width / 2
        initialLettersLabel.text = "\(employee.firstName?.prefix(1) ?? "")\(employee.lastName?.prefix(1) ?? "")"
        employee.contact != nil ? (detailImageView.isHidden = false) : (detailImageView.isHidden = true)
        
        let gradientLayer = CAGradientLayer().makeGradient(topColor: #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1), bottomColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        gradientLayer.frame = initialLettersView.bounds
        initialLettersView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
