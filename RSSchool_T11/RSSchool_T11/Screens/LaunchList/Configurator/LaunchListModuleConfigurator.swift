//
//  LaunchListModuleConfigurator.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 30/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class LaunchListModuleConfigurator {

    // MARK: - Internal methods

    func configure(output: LaunchListModuleOutput? = nil) -> LaunchListViewController {
        let view = LaunchListViewController()
        let presenter = LaunchListPresenter()
        let router = LaunchListRouter()

        presenter.view = view
        presenter.router = router
        presenter.output = output
        router.view = view
        view.output = presenter

        return view
    }

}
