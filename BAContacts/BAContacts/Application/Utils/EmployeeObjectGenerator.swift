//
//  EmployeeObjectGenerator.swift
//  Contacts
//
//  Created by Burak Akyalcin on 26.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

struct EmployeeObject {
    var projectName: String
    var employees: [Employee]
}

class EmployeeObjectsGenerator {
    static func generateEmptyObjectsFromEmployeeArray(_ employees: [Employee]) -> [EmployeeObject] {
        let dict = Dictionary(grouping: employees, by: { $0.position ?? "OTHER"})
        var employees: [EmployeeObject] = []
        
        for (key, value) in dict {
            employees.append(EmployeeObject(projectName: key, employees: value))
        }
        
        return employees.sorted(by: {$0.projectName < $1.projectName})
    }
}
