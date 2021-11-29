//
//  ImageDetailViewInput.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 23/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

protocol ImageDetailViewInput: AnyObject, LoaderDisplayable {
    func setupImage(_ img: UIImage)
}
