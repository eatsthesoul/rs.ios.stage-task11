//
//  RocketsListModuleConfigurator.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 28/09/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class RocketsListModuleConfigurator {

    // MARK: - Internal methods

    func configure(output: RocketsListModuleOutput? = nil) -> RocketsListViewController {
        let view = RocketsListViewController()
        let presenter = RocketsListPresenter()
        let router = RocketsListRouter()

        presenter.view = view
        presenter.router = router
        presenter.output = output
        router.view = view
        view.output = presenter

        return view
    }

}
