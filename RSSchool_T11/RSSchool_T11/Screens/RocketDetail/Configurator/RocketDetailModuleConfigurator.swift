//
//  RocketDetailModuleConfigurator.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class RocketDetailModuleConfigurator {

    // MARK: - Internal methods

    func configure(with rocket: Rocket, output: RocketDetailModuleOutput? = nil) -> RocketDetailViewController {
        let view = RocketDetailViewController(nibName: "RocketDetailViewController", bundle: nil)
        let presenter = RocketDetailPresenter()
        let router = RocketDetailRouter()

        presenter.view = view
        presenter.router = router
        presenter.output = output
        router.view = view
        
        presenter.rocket = rocket
        view.output = presenter

        return view
    }

}
