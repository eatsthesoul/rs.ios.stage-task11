//
//  LaunchpadListModuleConfigurator.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21.12.21.
//

import Foundation

final class LaunchpadListModuleConfigurator {
    
    // MARK: - Internal methods
    
    func configure() -> LaunchpadListViewController {
        let view = LaunchpadListViewController()
        let presenter = LaunchpadListPresenter()
        let router = LaunchpadListRouter()
        
        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter
        
        return view
    }
    
}
