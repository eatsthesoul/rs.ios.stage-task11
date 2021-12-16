//
//  LaunchDetailRouter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 08/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class LaunchDetailRouter: LaunchDetailRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - LaunchDetailRouterInput
    
    func showPictureInDetail(for url: String) {
        let imageDetailConfigurator = ImageDetailModuleConfigurator()
        let imageDetailViewController = imageDetailConfigurator.configure(with: url)
        imageDetailViewController.modalPresentationStyle = .fullScreen
        view?.presentModule(imageDetailViewController, animated: true, completion: nil)
    }
    
    func showWebPage(for url: String) {
        let webViewConfigurator = WebPageModuleConfigurator()
        let webViewController = webViewConfigurator.configure(with: url)
        view?.push(module: webViewController, animated: true, hideTabBar: false)
    }

}
