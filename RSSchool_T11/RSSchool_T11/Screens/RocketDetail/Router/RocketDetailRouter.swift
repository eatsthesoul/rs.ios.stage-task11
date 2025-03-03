//
//  RocketDetailRouter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class RocketDetailRouter: RocketDetailRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - RocketDetailRouterInput
    
    func showRocketWikiWith(_ url: String) {
        let webViewConfigurator = WebPageModuleConfigurator()
        let webViewController = webViewConfigurator.configure(with: url)
        view?.push(module: webViewController, animated: true, hideTabBar: false)
    }
    
    func showPictureInDetail(for url: String) {
        let imageDetailConfigurator = ImageDetailModuleConfigurator()
        let imageDetailViewController = imageDetailConfigurator.configure(with: url)
        imageDetailViewController.modalPresentationStyle = .fullScreen
        view?.presentModule(imageDetailViewController, animated: true, completion: nil)
    }
}
