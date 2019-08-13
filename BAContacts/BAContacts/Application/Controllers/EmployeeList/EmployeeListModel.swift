//
//  EmployeeListModel.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation
import Contacts
import ContactsUI

protocol EmployeeListModelProtocol: class {
    var delegate: EmployeeListModelDelegate? { get }
    
    func fetchEmployees()
    func fetchPhoneContacts()
}

protocol EmployeeListModelDelegate: class {
    func fetchEmployeesSucceeded(employees: [Employee])
    func fetchEmployeesFailed(error: Error)
    
    func fetchContactsSucceeded(contacts: [CNContact])
    func fetchContactsFailed(error: Error)
}

class EmployeeListModel: EmployeeListModelProtocol {
    weak var delegate: EmployeeListModelDelegate?
    var service: EmployeeListServiceAdapterProtocol!
    
    init(delegate: EmployeeListModelDelegate) {
        self.delegate = delegate
        service = EmployeeListServiceAdapter()
    }
    
    func fetchEmployees() {
        service.getEmployees(onSuccess: { [weak self] response in
            self?.delegate?.fetchEmployeesSucceeded(employees: response.employees)
        }, onFailure: { [weak self] error in
            self?.delegate?.fetchEmployeesFailed(error: error)
        })
    }
    
    func fetchPhoneContacts() {
        service.fetchPhoneContacts(onSuccess: { [weak self] contacts in
            self?.delegate?.fetchContactsSucceeded(contacts: contacts)
        }, onFailure: { [weak self] error in
            self?.delegate?.fetchContactsFailed(error: error)
        })
    }
}
