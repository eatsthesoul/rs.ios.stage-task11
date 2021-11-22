//
//  MarginLabel.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 22.11.21.
//

import UIKit

class MarginLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
