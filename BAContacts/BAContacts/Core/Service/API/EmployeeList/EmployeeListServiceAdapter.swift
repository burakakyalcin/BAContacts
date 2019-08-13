//
//  EmployeeListServiceAdapterProtocol.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import Foundation
import ContactsUI

protocol EmployeeListServiceAdapterProtocol: class {
    func getEmployees(onSuccess: @escaping (EmployeeResponse) -> Void , onFailure: @escaping (Error) -> Void)
    func fetchPhoneContacts(onSuccess: @escaping ([CNContact]) -> Void, onFailure: @escaping (Error) -> Void)
}

class EmployeeListServiceAdapter: EmployeeListServiceAdapterProtocol {
    func getEmployees(onSuccess: @escaping (EmployeeResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://tallinn-jobapp.aw.ee/employee_list") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let employeeResponse = try JSONDecoder().decode(EmployeeResponse.self, from: data)
                print(employeeResponse)
                DispatchQueue.main.async {
                    onSuccess(employeeResponse)
                }
            } catch let err {
                print(err)
                DispatchQueue.main.async {
                    onFailure(err)
                }
            }
        }
        task.resume()
    }
    
    func fetchPhoneContacts(onSuccess: @escaping ([CNContact]) -> Void, onFailure: @escaping (Error) -> Void) {
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactViewController.descriptorForRequiredKeys(),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                contacts.append(contact)
            }
            onSuccess(contacts)
        }
        catch let error {
            onFailure(error)
        }
    }
}
