//
//  RocketDetailPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

enum RocketLinkType {
    case wikipedia
}

final class RocketDetailPresenter: NSObject, RocketDetailViewOutput, RocketDetailModuleInput {

    // MARK: - Properties

    weak var view: RocketDetailViewInput?
    var router: RocketDetailRouterInput?
    var output: RocketDetailModuleOutput?
    
    let networkService: NetworkServiceProtocol
    var rocket: Rocket?
    
    override init() {
        networkService = NetworkService()
        super.init()
    }
    

    // MARK: - RocketDetailViewOutput
    
    func viewDidLoad() {
        setupRocketData()
        setupCoverImage()
    }
    
    func didSelectRocketImage(with index: Int) {
        guard let url = rocket?.images?[index] else { return }
        router?.showPictureInDetail(for: url)
    }
    
    func showRocketMaterial(_ type: RocketLinkType) {
        
        switch type {
        case .wikipedia:
            guard let wikiURL = rocket?.wikipedia else { return }
            router?.showRocketWikiWith(wikiURL)
        }
    }
    
    
    // MARK: - RocketDetailModuleInput

}

// MARK: - Private methods

private extension RocketDetailPresenter {
    
    func setupRocketData() {
        guard let rocket = rocket else { return }
        self.rocket = rocket
        view?.setup(with: rocket)
        
        if let images = rocket.images, images.count > 0 {
            view?.reloadRocketImages()
        } else {
            view?.hideRocketImages()
        }
    }
    
    func setupCoverImage() {
        guard let imgURL = rocket?.images?.first else { return }
        networkService.imageService.loadImage(for: imgURL) { [weak self] image, error in
            if let error = error {
                print(error)
                return
            }
            guard let image = image else { return }
            self?.view?.setupRocketCoverImage(image)
        }
    }
}
