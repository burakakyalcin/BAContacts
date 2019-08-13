//
//  EmployeeFilterManager.swift
//  BAContacts
//
//  Created by Burak Akyalcin on 30.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

class EmployeeFilterManager {
    
    var employees: [Employee] = []
    
    init(employees: [Employee]) {
        self.employees = employees
    }
    
    func filter(with text: String) -> [Employee] {
        var filteredEmployees: [Employee] = []

        filteredEmployees.append(contentsOf: employees.filter({$0.firstName?.lowercased().contains(text.lowercased()) ?? false}))
        filteredEmployees.append(contentsOf: employees.filter({$0.lastName?.lowercased().contains(text.lowercased()) ?? false}))
        filteredEmployees.append(contentsOf: employees.filter({$0.contactDetails?.email?.lowercased().contains(text.lowercased()) ?? false}))
        filteredEmployees.append(contentsOf: employees.filter({$0.position?.lowercased().contains(text.lowercased()) ?? false}))
        filteredEmployees.append(contentsOf: employees.filter({$0.hasProject(with: text)}))
        
        return Array(Set(filteredEmployees))
    }
}
