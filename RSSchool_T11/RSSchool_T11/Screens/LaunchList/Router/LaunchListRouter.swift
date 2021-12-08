//
//  LaunchListRouter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 30/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class LaunchListRouter: LaunchListRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - LaunchListRouterInput

    func showLaunchDetailModule(for launch: Launch) {
        let launchDetailConfigurator = LaunchDetailModuleConfigurator()
        let launchDetailViewController = launchDetailConfigurator.configure(with: launch)
        view?.push(module: launchDetailViewController, animated: true)
    }
}
