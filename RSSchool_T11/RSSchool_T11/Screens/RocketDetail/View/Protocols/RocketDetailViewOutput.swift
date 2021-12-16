//
//  RocketDetailViewOutput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

protocol RocketDetailViewOutput: UICollectionViewDataSource {
    func viewDidLoad()
    func didSelectRocketImage(with index: Int)
    func showRocketMaterial(_ type: RocketLinkType)
}
