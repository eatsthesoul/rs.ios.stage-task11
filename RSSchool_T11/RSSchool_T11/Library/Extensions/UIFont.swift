//
//  UIFont.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 7.10.21.
//

import UIKit

extension UIFont {
    
    enum FontWeight: String {
        case bold
        case medium
    }
    
    static func roboto(_ size: CGFloat, _ weight: FontWeight) -> UIFont {
        UIFont(name: "Roboto-\(weight.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: size)
    }
}
