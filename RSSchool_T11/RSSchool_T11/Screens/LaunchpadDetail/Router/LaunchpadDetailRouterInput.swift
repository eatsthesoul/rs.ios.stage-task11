//
//  LaunchpadDetailRouterInput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import Foundation

protocol LaunchpadDetailRouterInput {
    func showPictureInDetail(for url: String)
    func showRocketsWith(ids: [String])
    func showLaunchesWith(ids: [String])
}
