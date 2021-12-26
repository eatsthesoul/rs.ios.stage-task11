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
    var displayingRockets: [Rocket]
    var rocketIDs: [String]?
    private var sortingParameters: (parameter: Rocket.SortingParameter, isAscending: Bool)?
    
    //MARK: - Initializers
    
    override init() {
        service = NetworkService()
        rockets = [Rocket]()
        displayingRockets = rockets
        super.init()
    }
    

    // MARK: - RocketsListViewOutput
    
    func viewDidLoad() {
        loadRockets()
    }
    
    func didSelectRocket(with index: Int) {
        router?.showRocketDetailModule(for: displayingRockets[index])
    }
    
    func sortRocketsBy(_ parameter: Rocket.SortingParameter) {
        if var sortingParameters = self.sortingParameters, sortingParameters.parameter == parameter {
            //set parameters
            sortingParameters.isAscending = !sortingParameters.isAscending
            self.sortingParameters = sortingParameters
            //sorting
            displayingRockets = sortingParameters.isAscending ?
            sortRockets(displayingRockets, by: parameter, isAscending: true) :
            sortRockets(displayingRockets, by: parameter, isAscending: false)
        } else {
            self.sortingParameters = (parameter, true)
            displayingRockets = sortRockets(displayingRockets, by: parameter, isAscending: true)
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
                self?.displayingRockets = filteringRockets
            //case when we need present all rockets
            case .none:
                self?.rockets = rockets
                self?.displayingRockets = rockets
            }
            
            self?.view?.reloadCollectionView()
            self?.view?.stopLoader()
        }
    }
    
    func sortRockets(_ rockets: [Rocket], by parameter: Rocket.SortingParameter, isAscending: Bool) -> [Rocket] {
        var sortedRockets = rockets
        
        switch parameter {
        case .launchCost:
            isAscending ?
            sortedRockets.sort { $0.launchCost! < $1.launchCost!} :
            sortedRockets.sort { $0.launchCost! > $1.launchCost! }
        case .successRate:
            isAscending ?
            sortedRockets.sort { $0.success! < $1.success! } :
            sortedRockets.sort { $0.success! > $1.success! }
        case .firstLaunch:
            isAscending ?
            sortedRockets.sort { $0.firstLaunch! < $1.firstLaunch! } :
            sortedRockets.sort { $0.firstLaunch! > $1.firstLaunch! }
        }
        
        return sortedRockets
    }
}
