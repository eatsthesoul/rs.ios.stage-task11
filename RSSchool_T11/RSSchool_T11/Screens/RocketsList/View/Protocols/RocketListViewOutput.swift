//
//  RocketListViewOutput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 28/09/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//
import UIKit

protocol RocketListViewOutput: UICollectionViewDataSource {
    func viewDidLoad()
    func didSelectRocket(with index: Int)
    func didEndDisplayingRocket(_ index: Int)
}
