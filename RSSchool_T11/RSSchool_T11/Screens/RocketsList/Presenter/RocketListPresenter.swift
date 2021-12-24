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
    
    let service: NetworkServiceProtocol
    var rockets: [Rocket]
    var rocketIDs: [String]?
    var rocketsSortingParameter: Rocket.SortingParameter?
    
    //MARK: - Initializers
    
    override init() {
        service = NetworkService()
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
    
    func sortRocketsBy(_ parameter: Rocket.SortingParameter) {
        switch parameter {
        case .firstLaunch:
            if let sortingParameter = rocketsSortingParameter, sortingParameter == .firstLaunch {
                rockets.sort { $0.firstLaunch! > $1.firstLaunch! }
                rocketsSortingParameter = nil
            } else {
                rockets.sort { $0.firstLaunch! < $1.firstLaunch! }
                rocketsSortingParameter = .firstLaunch
            }
        case .launchCost:
            if let sortingParameter = rocketsSortingParameter, sortingParameter == .launchCost {
                rockets.sort { $0.launchCost! > $1.launchCost! }
                rocketsSortingParameter = nil
            } else {
                rockets.sort { $0.launchCost! < $1.launchCost! }
                rocketsSortingParameter = .launchCost
            }
        case .successRate:
            if let sortingParameter = rocketsSortingParameter, sortingParameter == .successRate {
                rockets.sort { $0.success! > $1.success! }
                rocketsSortingParameter = nil
            } else {
                rockets.sort { $0.success! < $1.success! }
                rocketsSortingParameter = .successRate
            }
        }
    }

    // MARK: - RocketsListModuleInput

}

//MARK: - Private Methods

private extension RocketListPresenter {
    
    func loadRockets() {
        view?.startLoader()
        service.requestService.loadRockets { [weak self] rockets, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let rockets = rockets else { return }
            
            switch self?.rocketIDs {
            //case when we need present rockets with a specific ID
            case .some(let rocketIDs):
                let filteringRockets = rockets.filter { rocket in
                    for rocketID in rocketIDs {
                        if rocket.id == rocketID { return true }
                    }
                    return false
                }
                self?.rockets = filteringRockets
            //case when we need present all rockets
            case .none:
                self?.rockets = rockets
            }
            
            self?.view?.reloadCollectionView()
            self?.view?.stopLoader()
        }
    }
}
