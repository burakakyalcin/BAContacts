//
//  AppDelegate.swift
//  Contacts
//
//  Created by Burak Akyalcin on 25.04.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit
import ContactsUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startApplication()
        return true
    }
    
    func startApplication() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController()
        
        guard let navigationController = self.window?.rootViewController as? UINavigationController else {
            fatalError("Root view controller not navigation controller")
        }
        
        self.appCoordinator = AppCoordinator(navigationController)
        self.appCoordinator?.start()
        self.window?.makeKeyAndVisible()
    }

}

