//
//  LaunchpadDetailModuleConfigurator.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class LaunchpadDetailModuleConfigurator {

    // MARK: - Internal methods

    func configure(with launchpad: Launchpad, output: LaunchpadDetailModuleOutput? = nil) -> LaunchpadDetailViewController {
        let view = LaunchpadDetailViewController(nibName: "LaunchpadDetailViewController", bundle: nil)
        let presenter = LaunchpadDetailPresenter()
        let router = LaunchpadDetailRouter()

        presenter.view = view
        presenter.router = router
        presenter.output = output
        router.view = view
        view.output = presenter
        
        presenter.launchpad = launchpad

        return view
    }
}
