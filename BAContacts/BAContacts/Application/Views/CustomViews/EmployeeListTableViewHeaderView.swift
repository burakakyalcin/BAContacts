//
//  EmployeeListTableViewHeaderView.swift
//  Contacts
//
//  Created by Burak Akyalcin on 26.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

class EmployeeListTableViewHeaderView: UIView {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        instantiateView()
    }
    
    func instantiateView() {
        Bundle.main.loadNibNamed(EmployeeListTableViewHeaderView.className, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setHeader(with text: String?) {
        titleLabel.text = text
    }
}
