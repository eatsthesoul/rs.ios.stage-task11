//
//  LaunchDetailViewOutput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 08/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

protocol LaunchDetailViewOutput: UICollectionViewDataSource {
    func viewDidLoad()
    func didSelectRocketImage(with index: Int)
}
