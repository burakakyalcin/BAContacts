//
//  EmployeeDetailTableViewAdapter.swift
//  Contacts
//
//  Created by Burak Akyalcin on 29.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//


import UIKit

protocol EmployeeDetailTableViewAdapterDelegate: class {
    
}

class EmployeeDetailTableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView
    weak var delegate: EmployeeDetailTableViewAdapterDelegate?
    
    var employee: Employee
    
    init(_ tableView: UITableView, employee: Employee) {
        self.tableView = tableView
        self.employee = employee
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerNibs()
    }
    
    func registerNibs() {
        EmployeeDetailTopTableViewCell.registerSelf(tableView)
        EmployeeDetailItemTableViewCell.registerSelf(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return cellForEmployeeDetailTopView(tableView, indexPath: indexPath, model: employee)
        default:
            return cellForEmployeeDetailInfo(tableView, indexPath: indexPath, model: employee)
        }
        
    }
    
    func cellForEmployeeDetailTopView(_ tableView: UITableView, indexPath: IndexPath, model: Employee) -> EmployeeDetailTopTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeDetailTopTableViewCell.className, for: indexPath) as? EmployeeDetailTopTableViewCell else { fatalError("Couldn't dequeue cell with identifier EmployeeDetailTopTableViewCell")}
        cell.setCell(with: model)
        return cell
    }
    
    func cellForEmployeeDetailInfo(_ tableView: UITableView, indexPath: IndexPath, model: Employee) -> EmployeeDetailItemTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeDetailItemTableViewCell.className, for: indexPath) as? EmployeeDetailItemTableViewCell else { fatalError("Couldn't dequeue cell with identifier EmployeeDetailTopTableViewCell")}
        cell.setCell(with: employee)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

