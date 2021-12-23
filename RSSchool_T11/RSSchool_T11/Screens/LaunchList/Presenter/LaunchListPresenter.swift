//
//  LaunchListPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 30/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import Foundation

final class LaunchListPresenter: NSObject, LaunchListViewOutput, LaunchListModuleInput {
    
    // MARK: - Properties

    weak var view: LaunchListViewInput?
    var router: LaunchListRouterInput?
    var output: LaunchListModuleOutput?
    
    let networkService: NetworkServiceProtocol
    var launches: [Launch]
    var launchIDs: [String]?
    
    //MARK: - Initializers
    
    override init() {
        networkService = NetworkService()
        launches = [Launch]()
        super.init()
    }

    // MARK: - LaunchListViewOutput
    
    func viewDidLoad() {
        loadLaunches()
    }
    
    func didSelectLaunch(with index: Int) {
        router?.showLaunchDetailModule(for: launches[index])
    }

    // MARK: - LaunchListModuleInput

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
                self?.launches = filteringRockets
            //case when we need present all launches
            case .none:
                self?.launches = launches
            }
            
            self?.view?.reloadCollectionView()
            self?.view?.stopLoader()
        }
    }
}
