//
//  LaunchListViewOutput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 30/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

protocol LaunchListViewOutput: UICollectionViewDataSource {
    func viewDidLoad()
    func didSelectLaunch(with index: Int)
    func sortLaunchesBy(_ parameter: Launch.SortingParameter)
    func filterLaunchesBy(_ parameter: Launch.FilteringParameter)
}
