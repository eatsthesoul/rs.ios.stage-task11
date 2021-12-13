//
//  LaunchDetailViewInput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 08/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

protocol LaunchDetailViewInput: AnyObject, ModelDataDisplayable, LoaderDisplayable {
    func setup(with launch: Launch)
    func setCoverImage(_ image: UIImage)
    func setupRocketView(with rocket: Rocket?)
    func setRocketViewCoverImage(_ image: UIImage)
    func hideRocketImages()
    func reloadRocketImages()
}
