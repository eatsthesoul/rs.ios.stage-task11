//
//  RocketDetailPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class RocketDetailPresenter: NSObject, RocketDetailViewOutput, RocketDetailModuleInput {

    // MARK: - Properties

    weak var view: RocketDetailViewInput?
    var router: RocketDetailRouterInput?
    var output: RocketDetailModuleOutput?
    
    let rocketService: RocketServiceProtocol = RocketService()
    var rocket: Rocket?
    

    // MARK: - RocketDetailViewOutput
    
    func viewDidLoad() {
        setupRocketData()
        setupCoverImage()
        
    }
    
    func didSelectRocketImage(with index: Int) {
        
    }
    
    func didEndDisplayingRocketImage(_ index: Int) {
        
    }
    
    func showRocketWikiWith(_ url: URL) {
        router?.showRocketWikiWith(url)
    }
    
    // MARK: - RocketDetailModuleInput

}

// MARK: - Private methods

private extension RocketDetailPresenter {
    
    func setupRocketData() {
        guard let rocket = rocket else { return }
        self.rocket = rocket
        view?.setup(with: rocket)
    }
    
    func setupCoverImage() {
        guard let imgURL = rocket?.images?.first else { return }
        rocketService.loadImage(for: imgURL) { [weak self] image, error in
            if let error = error {
                print(error)
                return
            }
            guard let image = image else { return }
            self?.view?.setupRocketCoverImage(image)
        }
    }
}
