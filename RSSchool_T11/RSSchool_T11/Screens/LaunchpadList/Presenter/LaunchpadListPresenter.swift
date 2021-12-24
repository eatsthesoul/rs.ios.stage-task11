//
//  LaunchpadListPresenter.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21.12.21.
//

import Foundation

final class LaunchpadListPresenter: NSObject {
    
    
    // MARK: - Properties

    weak var view: LaunchpadListViewInput?
    var router: LaunchpadListRouterInput?
    
    
    let networkService: NetworkServiceProtocol
    var launchpads: [Launchpad]
    var launchpadsSortingParameter: Launchpad.SortingParameter?
    
    //MARK: - Initializers
    
    override init() {
        networkService = NetworkService()
        launchpads = [Launchpad]()
        super.init()
    }
}

// MARK: - LaunchpadListViewOutput

extension LaunchpadListPresenter: LaunchpadListViewOutput {
    
    func viewDidLoad() {
        loadLaunchpads()
    }
    
    func didSelectLaunch(with index: Int) {
        guard index < launchpads.count else { return }
        let launchpad = launchpads[index]
        router?.showLaunchpadDetailModule(for: launchpad)
    }
    
    func sortLaunchpadsBy(_ parameter: Launchpad.SortingParameter) {
        switch parameter {
        case .title:
            if let sortingParameter = launchpadsSortingParameter, sortingParameter == .title {
                launchpads.sort { $0.name! > $1.name! }
                launchpadsSortingParameter = nil
            } else {
                launchpads.sort { $0.name! < $1.name! }
                launchpadsSortingParameter = .title
            }
        case .region:
            if let sortingParameter = launchpadsSortingParameter, sortingParameter == .region {
                launchpads.sort { $0.region! > $1.region! }
                launchpadsSortingParameter = nil
            } else {
                launchpads.sort { $0.region! < $1.region! }
                launchpadsSortingParameter = .region
            }
        case .status:
            if let sortingParameter = launchpadsSortingParameter, sortingParameter == .status {
                launchpads.sort { $0.status > $1.status }
                launchpadsSortingParameter = nil
            } else {
                launchpads.sort { $0.status < $1.status }
                launchpadsSortingParameter = .status
            }
        }
    }
}

//MARK: - Private methods

extension LaunchpadListPresenter {
    
    func loadLaunchpads() {
        view?.startLoader()
        networkService.requestService.loadLaunchpads { [weak self] launchpads, error in
            if let error = error {
                print(error)
                return
            }
            guard let launchpads = launchpads else { return }
            self?.launchpads = launchpads
            self?.view?.reloadCollectionView()
            self?.view?.stopLoader()
        }
    }
}
