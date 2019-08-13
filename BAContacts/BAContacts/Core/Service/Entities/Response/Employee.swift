//
//  Employee.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation
import Contacts

class Employee: Hashable, Codable, NSCoding {
    var firstName: String?
    var lastName: String?
    var contactDetails: ContactDetail?
    var position: String?
    var projects: [String]? = nil
    var contact: CNContact?
    
    enum CodingKeys: String, CodingKey {
        case firstName =  "fname"
        case lastName = "lname"
        case contactDetails = "contact_details"
        case position = "position"
        case projects = "projects"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(position, forKey: "position")
        aCoder.encode(projects, forKey: "projects")
        aCoder.encode(contactDetails, forKey: "contactDetails")
        aCoder.encode(contact, forKey: "contact")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        self.contactDetails = aDecoder.decodeObject(forKey: "contactDetails") as? ContactDetail
        self.position = aDecoder.decodeObject(forKey: "position") as? String
        self.projects = aDecoder.decodeObject(forKey: "projects") as? [String]
        self.contact = aDecoder.decodeObject(forKey: "contact") as? CNContact
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
    
    func set(contacts: [CNContact]) {
        guard let index = contacts.firstIndex(where: {"\($0.givenName) \($0.familyName)".lowercased() == "\(firstName ?? "") \(lastName ?? "")".lowercased()}) else { return }
        contact = contacts[index]
    }
    
    func hasProject(with text: String) -> Bool {
        if projects != nil {
            return projects!.contains(where: {$0.range(of: text, options: .caseInsensitive) != nil})
        }
        return false
    }
    
}

class ContactDetail: NSObject, Codable, NSCoding {
    var email: String?
    var phone: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case phone = "phone"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phone, forKey: "phone")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String
    }
}
