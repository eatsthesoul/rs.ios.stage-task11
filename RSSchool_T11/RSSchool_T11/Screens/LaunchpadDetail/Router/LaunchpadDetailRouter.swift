//
//  LaunchpadDetailRouter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class LaunchpadDetailRouter: LaunchpadDetailRouterInput {

	// MARK: - Properties

    weak var view: ModuleTransitionable?

	// MARK: - LaunchpadDetailRouterInput
    
    func showPictureInDetail(for url: String) {
        let imageDetailConfigurator = ImageDetailModuleConfigurator()
        let imageDetailViewController = imageDetailConfigurator.configure(with: url)
        imageDetailViewController.modalPresentationStyle = .fullScreen
        view?.presentModule(imageDetailViewController, animated: true, completion: nil)
    }
}
