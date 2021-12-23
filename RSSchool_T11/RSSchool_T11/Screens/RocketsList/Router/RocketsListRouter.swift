//
//  RocketsListRouter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 28/09/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class RocketsListRouter: RocketsListRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - RocketsListRouterInput
    
    func showRocketDetailModule(for rocket: Rocket) {
        let rocketDetailConfigurator = RocketDetailModuleConfigurator()
        let rocketDetailViewController = rocketDetailConfigurator.configure(with: rocket)
        view?.push(module: rocketDetailViewController, animated: true, hideTabBar: true)
    }

}
