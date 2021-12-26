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
    var displayingLaunchpads: [Launchpad]
    var launchpadsSortingParameter: Launchpad.SortingParameter?
    private var sortingParameters: (parameter: Launchpad.SortingParameter, isAscending: Bool)?
    
    //MARK: - Initializers
    
    override init() {
        networkService = NetworkService()
        launchpads = [Launchpad]()
        displayingLaunchpads = launchpads
        super.init()
    }
}

// MARK: - LaunchpadListViewOutput

extension LaunchpadListPresenter: LaunchpadListViewOutput {
    
    func viewDidLoad() {
        loadLaunchpads()
    }
    
    func didSelectLaunch(with index: Int) {
        guard index < displayingLaunchpads.count else { return }
        let launchpad = displayingLaunchpads[index]
        router?.showLaunchpadDetailModule(for: launchpad)
    }
    
    func sortLaunchpadsBy(_ parameter: Launchpad.SortingParameter) {
        if var sortingParameters = self.sortingParameters, sortingParameters.parameter == parameter {
            //set parameters
            sortingParameters.isAscending = !sortingParameters.isAscending
            self.sortingParameters = sortingParameters
            //sorting
            displayingLaunchpads = sortingParameters.isAscending ?
            sortLaunchpads(displayingLaunchpads, by: parameter, isAscending: true) :
            sortLaunchpads(displayingLaunchpads, by: parameter, isAscending: false)
        } else {
            self.sortingParameters = (parameter, true)
            displayingLaunchpads = sortLaunchpads(displayingLaunchpads, by: parameter, isAscending: true)
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
            self?.displayingLaunchpads = launchpads
            self?.view?.reloadCollectionView()
            self?.view?.stopLoader()
        }
    }
    
    func sortLaunchpads(_ launchpads: [Launchpad], by parameter: Launchpad.SortingParameter, isAscending: Bool) -> [Launchpad] {
        var sortedLaunchpads = launchpads
        
        switch parameter {
        case .region:
            isAscending ? sortedLaunchpads.sort { $0.region! < $1.region! } : sortedLaunchpads.sort { $0.region! > $1.region! }
        case .title:
            isAscending ? sortedLaunchpads.sort { $0.name! < $1.name! } : sortedLaunchpads.sort { $0.name! > $1.name! }
        case .status:
            isAscending ? sortedLaunchpads.sort { $0.status < $1.status } : sortedLaunchpads.sort { $0.status > $1.status }
        }
        
        return sortedLaunchpads
    }
}
