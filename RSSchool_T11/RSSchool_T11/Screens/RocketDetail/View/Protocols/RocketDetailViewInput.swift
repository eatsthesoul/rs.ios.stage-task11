//
//  RocketDetailViewInput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

protocol RocketDetailViewInput: AnyObject {
    func setup(with rocket: Rocket)
    func setupRocketCoverImage(_ image: UIImage)
}
