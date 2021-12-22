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
