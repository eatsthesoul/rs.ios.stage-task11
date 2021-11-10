//
//  Double.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 10.11.21.
//

import Foundation

extension Double {
    var clean: String {
        self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
