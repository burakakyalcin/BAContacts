//
//  EmployeeListViewModel.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit
import Contacts

protocol EmployeeListViewModelProtocol: class {
    var delegate: EmployeeListViewModelDelegate? { get }
    var employees: [Employee] { get }
    
    func fetchEmployees()
    func fetchLocalEmployees()
    func fetchPhoneContacts()
}

protocol EmployeeListViewModelDelegate: class {
    func fetchEmployeesSucceeded()
    func fetchEmployeesFailed(error: Error)
    
    func fetchContactsFailed(error: Error)
}

class EmployeeListViewModel: EmployeeListViewModelProtocol {
    
    weak var delegate: EmployeeListViewModelDelegate?
    var model: EmployeeListModelProtocol!
    
    var employees: [Employee] = []
    
    init(delegate: EmployeeListViewModelDelegate?) {
        self.delegate = delegate
        model = EmployeeListModel(delegate: self)
    }
    
    func fetchEmployees() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        model.fetchEmployees()
    }
    
    func fetchLocalEmployees() {
        if let employeesData = UserDefaults.standard.data(forKey: "employees"),
            let employees = try? JSONDecoder().decode([Employee].self, from: employeesData) {
            self.employees = employees
            delegate?.fetchEmployeesSucceeded()
        }
    }
    
    func fetchPhoneContacts() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        model.fetchPhoneContacts()
    }
}

extension EmployeeListViewModel: EmployeeListModelDelegate {
    func fetchEmployeesSucceeded(employees: [Employee]) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.employees = employees.sorted { $0.lastName ?? "" < $1.lastName ?? ""}
        fetchPhoneContacts()
    }
    
    func fetchEmployeesFailed(error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        delegate?.fetchEmployeesFailed(error: error)
    }
    
    func fetchContactsSucceeded(contacts: [CNContact]) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        employees.forEach { $0.set(contacts: contacts) }
        saveEmployees(employees)
        delegate?.fetchEmployeesSucceeded()
    }
    
    func fetchContactsFailed(error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        delegate?.fetchContactsFailed(error: error)
    }
    
    func saveEmployees(_ employees: [Employee]) {
        if let encoded = try? JSONEncoder().encode(employees) {
            UserDefaults.standard.set(encoded, forKey: "employees")
        }
    }
}
