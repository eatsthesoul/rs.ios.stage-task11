//
//  LaunchpadListRouter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21.12.21.
//

import Foundation

final class LaunchpadListRouter: LaunchpadListRouterInput {

    // MARK: - Properties

    weak var view: ModuleTransitionable?

    // MARK: - LaunchpadListRouterInput

    func showLaunchpadDetailModule(for launchpad: Launchpad) {
        let launchpadDetailConfigurator = LaunchpadDetailModuleConfigurator()
        let launchpadDetailViewController = launchpadDetailConfigurator.configure(with: launchpad)
        view?.push(module: launchpadDetailViewController, animated: true, hideTabBar: true)
    }
}
