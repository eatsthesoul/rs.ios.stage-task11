//
//  WebViewConfigurator.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 14.12.21.
//

import UIKit

final class WebPageModuleConfigurator {

    // MARK: - Internal methods

    func configure(with url: String) -> WebPageViewController {
        
        let view = WebPageViewController(nibName: "WebPageViewController", bundle: nil)
        view.url = url

        return view
    }

}

//let view = RocketDetailViewController(nibName: "RocketDetailViewController", bundle: nil)
//let presenter = RocketDetailPresenter()
//let router = RocketDetailRouter()
//
//presenter.view = view
//presenter.router = router
//presenter.output = output
//router.view = view
//
//presenter.rocket = rocket
//view.output = presenter
//
//return view
