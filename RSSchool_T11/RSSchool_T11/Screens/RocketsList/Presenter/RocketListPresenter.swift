//
//  RocketListPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 28/09/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class RocketListPresenter: NSObject, RocketListViewOutput, RocketListModuleInput {
    
    
    // MARK: - Properties

    weak var view: RocketListViewInput?
    var router: RocketsListRouterInput?
    var output: RocketListModuleOutput?
    
    let rocketService: RocketServiceProtocol
    var rockets: [Rocket]
    
    //MARK: - Initializers
    
    override init() {
        rocketService = RocketService()
        rockets = [Rocket]()
        super.init()
    }
    

    // MARK: - RocketsListViewOutput
    
    func viewDidLoad() {
        loadRockets()
    }
    
    func didSelectRocket(with index: Int) {
        router?.showRocketDetailModule(for: rockets[index])
    }
    
    func didEndDisplayingRocket(_ index: Int) {
        guard let imageURL = rockets[index].images?.first else { return }
        rocketService.cancelLoadingImage(for: imageURL)
    }

    // MARK: - RocketsListModuleInput

}

//MARK: - Private Methods

private extension RocketListPresenter {
    
    func loadRockets() {
        view?.startLoader()
        rocketService.loadRockets { [weak self] rockets, error in
            if let error = error {
                print(error)
                return
            }
            guard let rockets = rockets else { return }
            self?.rockets = rockets
            self?.view?.reloadCollectionView()
            self?.view?.stopLoader()
        }
    }
    
}
