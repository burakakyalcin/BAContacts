//
//  EmployeeDetailViewModel.swift
//  Contacts
//
//  Created by Burak Akyalcin on 29.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation
import Contacts

protocol EmployeeDetailViewModelProtocol: class {
    var delegate: EmployeeDetailViewModelDelegate? { get }
    var employee: Employee { get set }
}

protocol EmployeeDetailViewModelDelegate: class {
    
}

class EmployeeDetailViewModel: EmployeeDetailViewModelProtocol {
    weak var delegate: EmployeeDetailViewModelDelegate?
    var employee: Employee
    
    init(employee: Employee, delegate: EmployeeDetailViewModelDelegate?) {
        self.employee = employee
        self.delegate = delegate
    }
}
