//
//  LaunchpadDetailRouter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class LaunchpadDetailRouter: LaunchpadDetailRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - LaunchpadDetailRouterInput
    
    func showPictureInDetail(for url: String) {
        let imageDetailConfigurator = ImageDetailModuleConfigurator()
        let imageDetailViewController = imageDetailConfigurator.configure(with: url)
        imageDetailViewController.modalPresentationStyle = .fullScreen
        view?.presentModule(imageDetailViewController, animated: true, completion: nil)
    }
    
    func showRocketsWith(ids: [String]) {
        let rocketsListModuleConfigurator = RocketsListModuleConfigurator()
        let rocketsListViewController = rocketsListModuleConfigurator.configure(with: ids)
        view?.push(module: rocketsListViewController, animated: true, hideTabBar: true)
    }
    
    func showLaunchesWith(ids: [String]) {
        let launchesListModuleConfigurator = LaunchListModuleConfigurator()
        let launchesListViewController = launchesListModuleConfigurator.configure(with: ids)
        view?.push(module: launchesListViewController, animated: true, hideTabBar: true)
    }
}
