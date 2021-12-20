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
        
        let launchpadListConfigurator = LaunchpadListModuleConfigurator()
        let launchpadListViewController = launchpadListConfigurator.configure()
        let launchpadNavigationController = UINavigationController(rootViewController: launchpadListViewController)
        launchpadNavigationController.tabBarItem.image = .lego
        launchpadNavigationController.tabBarItem.selectedImage = .lego
        launchpadNavigationController.tabBarItem.title = "Launchpads"
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [rocketNavigationController, launchNavigationController, launchpadNavigationController]
        
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        configureAppearance()
        
        return true
    }
}

extension AppDelegate {
    
    func configureAppearance() {
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = .coral
        tabBarAppearance.unselectedItemTintColor = .champagne
        tabBarAppearance.barTintColor = .queenBlue
        tabBarAppearance.backgroundImage = UIImage()
        
        let tabBarItemAppearance = UITabBarItem.appearance()
        tabBarItemAppearance.setTitleTextAttributes([.font: UIFont.roboto(10, .medium),
                                                     .foregroundColor: UIColor.champagne],
                                                    for: .normal)
        tabBarItemAppearance.setTitleTextAttributes([.font: UIFont.roboto(10, .medium),
                                                     .foregroundColor: UIColor.coral],
                                                    for: .selected)
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = .queenBlue
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearance.titleTextAttributes = [.font: UIFont.roboto(24, .bold), .foregroundColor : UIColor.smokyWhite]
        
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.setTitleTextAttributes([.font: UIFont.roboto(17, .medium), .foregroundColor: UIColor.champagne], for: .highlighted)
        barButtonItemAppearance.setTitleTextAttributes([.font: UIFont.roboto(17, .medium), .foregroundColor: UIColor.coral], for: .normal)
        barButtonItemAppearance.tintColor = .coral
    }
}


