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
    
    let launchService: LaunchServiceProtocol
    let downloadManager: DownloadManagerProtocol
    var launches: [Launch]
    
    //MARK: - Initializers
    
    override init() {
        launchService = LaunchService()
        downloadManager = DownloadManager()
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
        launchService.loadLaunches { [weak self] launches, error in
            if let error = error {
                print(error)
                return
            }
            guard let launches = launches else { return }
            self?.launches = launches
            self?.view?.reloadCollectionView()
            self?.view?.stopLoader()
        }
    }
}
