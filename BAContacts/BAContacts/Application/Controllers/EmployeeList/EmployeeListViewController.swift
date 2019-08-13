//
//  ViewController.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit
import Contacts

class EmployeeListViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var tableView: UITableView!
    
    let searchBar = UISearchBar()
    let refreshControl = UIRefreshControl()
    var errorView: BAErrorView!

    weak var coordinator: EmployeeListCoordinator?
    var viewModel: EmployeeListViewModelProtocol!
    var tableViewAdapter: EmployeeListTableViewAdapter!
    
    var filterManager: EmployeeFilterManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAccess { [weak self] in
            DispatchQueue.main.async {
                self?.configureTableViewAdapter()
                self?.configureRefreshControl()
                self?.configureSearchBar()
                
                self?.viewModel.fetchLocalEmployees()
                self?.viewModel.fetchEmployees()
            }
        }
    }
    
    func requestAccess(completionHandler: @escaping () -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completionHandler()
        case .denied:
            showSettingsAlert(completionHandler)
        case .restricted, .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                if granted {
                    completionHandler()
                } else {
                    DispatchQueue.main.async {
                        self.showSettingsAlert(completionHandler)
                    }
                }
            }
        @unknown default:
            break
        }
    }
    
    private func showSettingsAlert(_ completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Would you like to open settings and grant permission to contacts?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
            completionHandler()
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionHandler()
        })
        present(alert, animated: true)
    }
    
    func configureTableViewAdapter() {
        tableViewAdapter = EmployeeListTableViewAdapter(tableView)
        tableViewAdapter.delegate = self
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        searchBar.placeholder = "Search for name, position, project etc."
        
        tableView.tableHeaderView = searchBar
    }

    func configureRefreshControl() {
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.9010759592, green: 0.9081327319, blue: 0.9145340323, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: nil)
    }
    
    func configureFilterManager() {
        filterManager = EmployeeFilterManager(employees: viewModel.employees)
    }
    
    func addErrorView(with type: BAErrorType) {
        errorView = BAErrorView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 100))
        errorView.delegate = self
        errorView.setView(with: type)
        view.addSubview(errorView)
        animateErrorView()
    }
    
    fileprivate func animateErrorView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else { return }
            self.errorView.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.frame.width, height: 100)
        })
    }
    
    fileprivate func closeErrorView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let self = self else { return }
            self.errorView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 100)
        }) { [weak self] _ in
            guard let self = self else { return }
            self.errorView.removeFromSuperview()
        }
    }
    
    @objc func refreshData() {
        viewModel.fetchEmployees()
    }

}


extension EmployeeListViewController: EmployeeListTableViewAdapterDelegate {
    func didSelect(employee: Employee) {
        coordinator?.displayEmployeeDetailViewController(with: employee)
    }
    
    func tableViewWillBeginDragging() {
        searchBar.resignFirstResponder()
    }
}

extension EmployeeListViewController: EmployeeListViewModelDelegate {
    func fetchEmployeesSucceeded() {
        configureFilterManager()
        refreshControl.endRefreshing()
        tableViewAdapter.updateData(with: viewModel.employees)
    }
    
    func fetchEmployeesFailed(error: Error) {
        refreshControl.endRefreshing()
        addErrorView(with: .fail(message: "Couldn't fetch employees. \(error.localizedDescription)"))
    }
    
    func fetchContactsFailed(error: Error) {
        refreshControl.endRefreshing()
        tableViewAdapter.updateData(with: viewModel.employees)
        addErrorView(with: .fail(message: "Employees are fetched but couldn't fetch contacts. \(error.localizedDescription)"))
    }
}

extension EmployeeListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            tableViewAdapter.updateData(with: viewModel.employees)
        } else {
            tableViewAdapter.updateData(with: filterManager.filter(with: searchText))
        }
    }
    
}


extension EmployeeListViewController: BAErrorViewDelegate {
    func didTapCloseButton(_ view: BAErrorView) {
        closeErrorView()
    }
}
