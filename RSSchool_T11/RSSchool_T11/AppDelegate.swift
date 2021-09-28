//
//  AppDelegate.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 28.09.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let rocketListViewController = RocketsListViewController()
        let navigationController = UINavigationController(rootViewController: rocketListViewController)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController]
        
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        return true
    }
}

