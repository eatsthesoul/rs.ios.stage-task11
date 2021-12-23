//
//  LaunchpadDetailViewOutput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

protocol LaunchpadDetailViewOutput: UICollectionViewDataSource {
    func viewDidLoad()
    func didSelectImage(with index: Int)
    func showLaunchMaterial(_ type: LaunchpadLinkType)
}
