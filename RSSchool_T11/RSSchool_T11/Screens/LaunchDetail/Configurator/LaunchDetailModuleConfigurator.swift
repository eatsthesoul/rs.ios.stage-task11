//
//  LaunchDetailModuleConfigurator.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 08/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class LaunchDetailModuleConfigurator {

    // MARK: - Internal methods

    func configure(with launch: Launch, output: LaunchDetailModuleOutput? = nil) -> LaunchDetailViewController {
        let view = LaunchDetailViewController(nibName: "LaunchDetailViewController", bundle: nil)
        let presenter = LaunchDetailPresenter()
        let router = LaunchDetailRouter()

        presenter.view = view
        presenter.router = router
        presenter.output = output
        router.view = view
        view.output = presenter
        
        presenter.launch = launch

        return view
    }

}
