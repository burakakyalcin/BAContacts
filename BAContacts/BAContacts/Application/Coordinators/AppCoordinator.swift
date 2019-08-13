//
//  AppCoordinator.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startEmployeeListCoordinator(with: navigationController)
    }
    
    func startEmployeeListCoordinator(with navigationController: UINavigationController) {
        let coordinator = EmployeeListCoordinator(navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
