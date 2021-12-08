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
    var launches: [Launch]
    
    //MARK: - Initializers
    
    override init() {
        launchService = LaunchService()
        launches = [Launch]()
        super.init()
    }

    // MARK: - LaunchListViewOutput
    
    func viewDidLoad() {
        loadLaunches()
    }
    
    func didSelectLaunch(with index: Int) {
        
    }
    
    func didEndDisplayingLaunch(_ index: Int) {
        guard let launchImageLink = launches[index].links?.patch?.small else { return }
        launchService.cancelLoadingImage(for: launchImageLink)
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
