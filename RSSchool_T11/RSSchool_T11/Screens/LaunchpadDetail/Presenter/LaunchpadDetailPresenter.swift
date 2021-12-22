//
//  LaunchpadDetailPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import Foundation

final class LaunchpadDetailPresenter: NSObject, LaunchpadDetailModuleInput {

    // MARK: - Properties

    weak var view: LaunchpadDetailViewInput?
    var router: LaunchpadDetailRouterInput?
    var output: LaunchpadDetailModuleOutput?
    
    var launchpad: Launchpad?
    
    let networkService: NetworkServiceProtocol
    
    override init() {
        networkService = NetworkService()
        super.init()
    }
}


// MARK: - LaunchpadDetailViewOutput
extension LaunchpadDetailPresenter: LaunchpadDetailViewOutput {
    
    func viewDidLoad() {
        guard let launchpad = launchpad else { return }
        view?.setup(with: launchpad)
    }
    
    func didSelectImage(with index: Int) {
        guard let imageURL = launchpad?.images?.large?[index] else { return }
        router?.showPictureInDetail(for: imageURL)
    }
}
