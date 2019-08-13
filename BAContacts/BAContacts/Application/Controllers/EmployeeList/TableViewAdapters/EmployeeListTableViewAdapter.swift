//
//  EmployeeListTableViewAdapter.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

protocol EmployeeListTableViewAdapterDelegate: class {
    func didSelect(employee: Employee)
    func tableViewWillBeginDragging()
}

class EmployeeListTableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView

    weak var delegate: EmployeeListTableViewAdapterDelegate?
    
    var employees: [EmployeeObject] = []
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerNibs()
    }
    
    func registerNibs() {
        EmployeeListItemTableViewCell.registerSelf(tableView)
        EmptyEmployeeListTableViewCell.registerSelf(tableView)
    }
    
    func updateData(with employees: [Employee]) {
        generateSections(from: employees)
        tableView.reloadData()
    }

    
    func generateSections(from employees: [Employee]) {
        self.employees = EmployeeObjectsGenerator.generateEmptyObjectsFromEmployeeArray(employees)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return employees.isEmpty ? 1 : employees.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if employees.isEmpty {
            return 1
        } else {
            return employees[section].employees.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if employees.isEmpty {
            return cellForEmptyList(tableView, indexPath: indexPath)
        } else {
            return cellForEmployeeListItem(tableView, indexPath: indexPath, model: employees[indexPath.section].employees[indexPath.row])
        }
    }
    
    func cellForEmployeeListItem(_ tableView: UITableView, indexPath: IndexPath, model: Employee) -> EmployeeListItemTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeListItemTableViewCell.className, for: indexPath) as? EmployeeListItemTableViewCell else { fatalError("Couldn't dequeue cell with identifier EmployeeListItemTableViewCell")}
        cell.setCell(with: model)
        return cell
    }
    
    func cellForEmptyList(_ tableView: UITableView, indexPath: IndexPath) -> EmptyEmployeeListTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyEmployeeListTableViewCell.className, for: indexPath) as? EmptyEmployeeListTableViewCell else { fatalError("Couldn't dequeue cell with identifier EmptyEmployeeListTableViewCell")}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return employees.isEmpty ? 120 : 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !employees.isEmpty {
            delegate?.didSelect(employee: employees[indexPath.section].employees[indexPath.row])
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.tableViewWillBeginDragging()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !employees.isEmpty {
            let view = EmployeeListTableViewHeaderView()
            view.setHeader(with: employees[section].projectName)
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return employees.isEmpty ? 0 : 48
    }
    
}
