//
//  LaunchDetailPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 08/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import Foundation

final class LaunchDetailPresenter: NSObject, LaunchDetailViewOutput, LaunchDetailModuleInput {

    // MARK: - Properties

    weak var view: LaunchDetailViewInput?
    var router: LaunchDetailRouterInput?
    var output: LaunchDetailModuleOutput?
    
    var launch: Launch?
    let launchService: LaunchServiceProtocol
    let rocketService: RocketServiceProtocol
    var downloadManager: DownloadManagerProtocol
    
    var rocketImagesURLs: [String]?
    
    override init() {
        launchService = LaunchService()
        rocketService = RocketService()
        downloadManager = DownloadManager()
    }

    // MARK: - LaunchDetailViewOutput
    
    func viewDidLoad() {
        setupViewsData()
        setupCoverImage()
    }
    
    func didSelectRocketImage(with index: Int) {
        guard let url = rocketImagesURLs?[index] else { return }
        router?.showPictureInDetail(for: url)
    }

    // MARK: - LaunchDetailModuleInput

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
        rocketService.loadRocket(with: rocketID) { [weak self] rocket, error in
            self?.view?.stopLoader()
            
            //rocket view data
            self?.view?.setupRocketView(with: rocket)
            
            
            //rockets images collection view
            guard let urls = rocket?.images, !urls.isEmpty else {
                self?.view?.hideRocketImages()
                return
            }
            self?.rocketImagesURLs = urls
            self?.view?.reloadRocketImages()
            
            //rocket view cover image
            self?.setupRocketViewCoverImage()
        }
    }
    
    func setupRocketViewCoverImage() {
        guard let url = rocketImagesURLs?.first else { return }
        downloadManager.loadImage(for: url, completion: { [weak self] image, error in
            guard let image = image else { return }
            self?.view?.setRocketViewCoverImage(image)
        })
    }
    
    func setupCoverImage() {
        guard let imageURL = launch?.links?.patch?.small else { return }
        downloadManager.loadImage(for: imageURL) { [weak self] image, error in
            if let err = error {
                print(err)
                return
            }
            guard let image = image else { return }
            self?.view?.setCoverImage(image)
        }
    }
}
