//
//  EmployeeListCoordinator.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit
import ContactsUI

class EmployeeListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = EmployeeListViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = EmployeeListViewModel(delegate: vc)
        vc.title = "Employees"
        navigationController.show(vc, sender: nil)
    }
    
    func displayEmployeeDetailViewController(with employee: Employee) {
        let vc = EmployeeDetailViewController.instantiate()
        vc.viewModel = EmployeeDetailViewModel(employee: employee, delegate: vc)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func displayContactDetail(with contact: CNContact) {
        let contactViewController = CNContactViewController(for: contact)
        navigationController.pushViewController(contactViewController, animated: true)
    }

}
