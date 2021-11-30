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
        
        let rocketsListConfigurator = RocketsListModuleConfigurator()
        let rocketListViewController = rocketsListConfigurator.configure()
        let rocketNavigationController = UINavigationController(rootViewController: rocketListViewController)
        rocketNavigationController.tabBarItem.image = .rocket
        rocketNavigationController.tabBarItem.selectedImage = .rocket
        rocketNavigationController.tabBarItem.title = "Rockets"
        
        let launchListConfigurator = LaunchListModuleConfigurator()
        let launchListViewController = launchListConfigurator.configure()
        let launchNavigationController = UINavigationController(rootViewController: launchListViewController)
        launchNavigationController.tabBarItem.image = .adjustment
        launchNavigationController.tabBarItem.selectedImage = .adjustment
        launchNavigationController.tabBarItem.title = "Launches"
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [rocketNavigationController, launchNavigationController]
        
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        return true
    }
}

