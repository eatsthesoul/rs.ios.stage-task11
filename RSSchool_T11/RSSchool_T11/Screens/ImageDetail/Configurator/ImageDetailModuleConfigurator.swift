//
//  ImageDetailModuleConfigurator.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 23/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class ImageDetailModuleConfigurator {

    // MARK: - Internal methods

    func configure(with url: String, output: ImageDetailModuleOutput? = nil) -> ImageDetailViewController {
        let view = ImageDetailViewController()
        let presenter = ImageDetailPresenter()
        let router = ImageDetailRouter()

        presenter.view = view
        presenter.router = router
        presenter.output = output
        router.view = view
        view.output = presenter
        
        presenter.url = url

        return view
    }
}
