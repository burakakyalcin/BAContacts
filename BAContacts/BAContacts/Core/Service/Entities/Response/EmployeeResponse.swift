//
//  EmployeeResponse.swift
//  Contacts
//
//  Created by Burak Akyalcin on 26.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation

class EmployeeResponse: Decodable {
    var employees: [Employee]
    
    enum CodingKeys: String, CodingKey {
        case employees = "employees"
    }
}
