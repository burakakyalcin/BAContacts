//
//  EmployeeDetailViewController.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class EmployeeDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var bottomViewHeightConstraint: NSLayoutConstraint!
    
    weak var coordinator: EmployeeListCoordinator?
    var viewModel: EmployeeDetailViewModelProtocol!
    var tableViewAdapter: EmployeeDetailTableViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBottomViewVisibility()
        configureTableViewAdapter()
    }
    
    func configureTableViewAdapter() {
        tableViewAdapter = EmployeeDetailTableViewAdapter(tableView, employee: viewModel.employee)
    }
    
    func configureBottomViewVisibility() {
        if viewModel.employee.contact == nil {
            bottomViewHeightConstraint.constant = 0
        }
    }
    
    @IBAction func goToContactsAction(_ sender: UIButton) {
        coordinator?.displayContactDetail(with: viewModel.employee.contact!)
    }
    
}

extension EmployeeDetailViewController: EmployeeDetailViewModelDelegate {
    
}
