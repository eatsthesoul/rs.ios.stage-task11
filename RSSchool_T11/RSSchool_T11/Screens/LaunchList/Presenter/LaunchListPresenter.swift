//
//  LaunchListPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 30/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import Foundation

final class LaunchListPresenter: NSObject, LaunchListModuleInput {
    
    // MARK: - Properties

    weak var view: LaunchListViewInput?
    var router: LaunchListRouterInput?
    var output: LaunchListModuleOutput?
    
    let networkService: NetworkServiceProtocol
    var displayingLaunches: [Launch]
    var launches: [Launch]
    var launchIDs: [String]?
    private var sortingParameters: (parameter: Launch.SortingParameter, isAscending: Bool)?
    
    //MARK: - Initializers
    
    override init() {
        networkService = NetworkService()
        displayingLaunches = [Launch]()
        launches = [Launch]()
        super.init()
    }
}

// MARK: - LaunchListViewOutput
extension LaunchListPresenter: LaunchListViewOutput {
    func viewDidLoad() {
        loadLaunches()
    }
    
    func didSelectLaunch(with index: Int) {
        router?.showLaunchDetailModule(for: displayingLaunches[index])
    }
    
    func sortLaunchesBy(_ parameter: Launch.SortingParameter) {
        if var sortingParameters = self.sortingParameters, sortingParameters.parameter == parameter {
            //set parameters
            sortingParameters.isAscending = !sortingParameters.isAscending
            self.sortingParameters = sortingParameters
            //sorting
            displayingLaunches = sortingParameters.isAscending ?
            sortLaunches(displayingLaunches, by: parameter, isAscending: true) :
            sortLaunches(displayingLaunches, by: parameter, isAscending: false)
        } else {
            self.sortingParameters = (parameter, true)
            displayingLaunches = sortLaunches(displayingLaunches, by: parameter, isAscending: true)
        }
    }
}

//MARK: - Private methods
extension LaunchListPresenter {
    
    func loadLaunches() {
        view?.startLoader()
        networkService.requestService.loadLaunches { [weak self] launches, error in
            if let error = error {
                print(error)
                return
            }
            guard let launches = launches else { return }
            
            switch self?.launchIDs {
            //case when we need present launches with a specific ID
            case .some(let launchIDs):
                let filteringRockets = launches.filter { launch in
                    for launchID in launchIDs {
                        if launch.id == launchID { return true }
                    }
                    return false
                }
                self?.displayingLaunches = filteringRockets
                self?.launches = filteringRockets
            //case when we need present all launches
            case .none:
                self?.displayingLaunches = launches
                self?.launches = launches
            }
            
            self?.view?.reloadCollectionView()
            self?.view?.stopLoader()
        }
    }
    
    func sortLaunches(_ launches: [Launch], by parameter: Launch.SortingParameter, isAscending: Bool) -> [Launch] {
        var sortedLaunches = launches
        
        switch parameter {
        case .launchDate:
            isAscending ?
            sortedLaunches.sort { $0.launchDate! < $1.launchDate! } :
            sortedLaunches.sort { $0.launchDate! > $1.launchDate! }
        case .title:
            isAscending ? sortedLaunches.sort { $0.name! < $1.name! } : sortedLaunches.sort { $0.name! > $1.name! }
        }
        
        return sortedLaunches
    }
}
