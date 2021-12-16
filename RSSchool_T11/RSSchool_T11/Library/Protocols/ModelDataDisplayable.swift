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
        if checkIfDataExist(string) {
            labels[0].text = string
        } else {
            // check if label stack is stack view
            if let superview = labels[0].superview as? UIStackView {
                if superview.tag == 345 {
                    superview.isHidden = true
                }
            }
            //hide labels
            labels.forEach { $0.isHidden = true }
            return
        }
    }
    
    func checkIfDataExist(_ data: Any?) -> Bool {
        
        if data == nil { return false }
        if let string = data as? String {
            let result = string.isEmpty ? false : true
            return result
        }
        return true
    }
    
    func checkIfStackViewIsVisible(_ stackView: UIStackView, with views: [UIView]) {
        
        var hiddenViewsCounter = 0
        views.forEach { view in
            if view.isHidden { hiddenViewsCounter += 1 }
        }
        stackView.isHidden = hiddenViewsCounter == views.count
    }
}



