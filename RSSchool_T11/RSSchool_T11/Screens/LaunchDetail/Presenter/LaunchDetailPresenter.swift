//
//  LaunchDetailPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 08/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import Foundation

enum LaunchLinkType {
    case wikipedia
    case youtube
    case redditRecovery
    case redditMedia
    case redditCampaign
    case redditLaunch
}

final class LaunchDetailPresenter: NSObject, LaunchDetailViewOutput, LaunchDetailModuleInput {

    

    // MARK: - Properties

    weak var view: LaunchDetailViewInput?
    var router: LaunchDetailRouterInput?
    var output: LaunchDetailModuleOutput?
    
    var launch: Launch?
    var rocket: Rocket?
    
    let networkService: NetworkServiceProtocol
    
    override init() {
        networkService = NetworkService()
    }
    
    // MARK: - LaunchDetailModuleInput

}

// MARK: - LaunchDetailViewOutput

extension LaunchDetailPresenter {
    
    func viewDidLoad() {
        setupViewsData()
        setupCoverImage()
    }
    
    func didSelectRocketImage(with index: Int) {
        guard let url = rocket?.images?[index] else { return }
        router?.showPictureInDetail(for: url)
    }
    
    func showLaunchMaterial(_ type: LaunchLinkType) {
        
        switch type {
        case .wikipedia:
            guard let wikiURL = launch?.links?.wikipedia else { return }
            router?.showWebPage(for: wikiURL)
        case .youtube:
            guard let youtubeURL = launch?.links?.youtube else { return }
            router?.showWebPage(for: youtubeURL)
        case .redditRecovery:
            guard let recoveryURL = launch?.links?.reddit?.recovery else { return }
            router?.showWebPage(for: recoveryURL)
        case .redditMedia:
            guard let mediaURL = launch?.links?.reddit?.media else { return }
            router?.showWebPage(for: mediaURL)
        case .redditCampaign:
            guard let campaignURL = launch?.links?.reddit?.campaign else { return }
            router?.showWebPage(for: campaignURL)
        case .redditLaunch:
            guard let launchURL = launch?.links?.reddit?.launch else { return }
            router?.showWebPage(for: launchURL)
        }
    }
    
    func showRocketDetailModule() {
        guard let rocket = rocket else { return }
        router?.showRocketDetailModule(for: rocket)
    }
}

// MARK: - Private methods

private extension LaunchDetailPresenter {
    
    func setupViewsData() {
        
        view?.startLoader()
        
        guard let launch = launch else { return }
        
        //launch data
        view?.setup(with: launch)
        
        //rocket data
        guard let rocketID = launch.rocket else { return }
        networkService.requestService.loadRocketWith(id: rocketID) { [weak self] rocket, error in
            self?.view?.stopLoader()
            self?.rocket = rocket
            
            //rocket view data
            self?.view?.setupRocketView(with: rocket)
            
            
            //rockets images collection view
            guard let urls = rocket?.images, !urls.isEmpty else {
                self?.view?.hideRocketImages()
                return
            }
            self?.view?.reloadRocketImages()
            
            //rocket view cover image
            self?.setupRocketViewCoverImage()
        }
    }
    
    func setupRocketViewCoverImage() {
        guard let url = rocket?.images?.first else { return }
        networkService.imageService.loadImage(for: url, completion: { [weak self] image, error in
            guard let image = image else { return }
            self?.view?.setRocketViewCoverImage(image)
        })
    }
    
    func setupCoverImage() {
        guard let imageURL = launch?.links?.patch?.small else { return }
        networkService.imageService.loadImage(for: imageURL) { [weak self] image, error in
            if let err = error {
                print(err)
                return
            }
            guard let image = image else { return }
            self?.view?.setCoverImage(image)
        }
    }
}
