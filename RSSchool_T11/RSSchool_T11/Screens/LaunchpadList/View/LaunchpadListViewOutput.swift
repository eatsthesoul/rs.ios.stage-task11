//
//  LaunchpadListViewOutput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21.12.21.
//

import UIKit

protocol LaunchpadListViewOutput: UICollectionViewDataSource {
    func viewDidLoad()
    func didSelectLaunch(with: Int)
    func sortLaunchpadsBy(_ parameter: Launchpad.SortingParameter)
    func filterLaunchpadsBy(_ parameter: Launchpad.FilteringParameter)
}
