//
//  ModelDataDisplayable.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 4.11.21.
//

import UIKit

protocol ModelDataDisplayable: ModelDataStringConvertable {
    //the first object in labels array need to be a label which getting a string
    //if the label stack is a stack view, it needs to have a tag 345
    func setupLabelStackData(_ labels: [UILabel], with string: String?)
}

extension ModelDataDisplayable {
    
    func setupLabelStackData(_ labels: [UILabel], with string: String?) {
        
        guard let string = string, !string.isEmpty else {
            //check if label stack is stack view
            if let superview = labels[0].superview as? UIStackView {
                if superview.tag == 345 {
                    superview.isHidden = true
                }
            }
            //hide labels
            labels.forEach { $0.isHidden = true }
            return
        }
        labels[0].text = string
    }
}



