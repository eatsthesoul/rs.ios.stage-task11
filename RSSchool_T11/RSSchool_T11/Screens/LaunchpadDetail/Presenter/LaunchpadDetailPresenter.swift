//
//  LaunchpadDetailPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import Foundation

enum LaunchpadLinkType {
    case rockets
    case launches
}

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
    
    func showLaunchMaterial(_ type: LaunchpadLinkType) {
        
        guard let launchpad = launchpad else { return }
        
        switch type {
        case .rockets:
            let rockets = launchpad.rockets
            router?.showRocketsWith(ids: rockets)
        case .launches:
            let launches = launchpad.launches
            router?.showLaunchesWith(ids: launches)
        }
    }
}
