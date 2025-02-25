//
//  ModelDataDisplayable.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 4.11.21.
//

import UIKit

protocol ModelDataDisplayable: ModelDataStringConvertable {
    //the first object in labels array need to be a label which getting a string
    func setupLabelStackData(_ labels: [UILabel], with string: String?)
    func checkIfDataExist(_ data: Any?) -> Bool
    func checkIfStackViewIsVisible(_ stackView: UIStackView, with views: [UIView])
}

extension ModelDataDisplayable {
    
    func setupLabelStackData(_ labels: [UILabel], with string: String?) {
        if checkIfDataExist(string) {
            labels[0].text = string
        } else {
            //hide labels
            labels.forEach { $0.isHidden = true }
        }
    }
    
    func checkIfDataExist(_ data: Any?) -> Bool {
        
        if data == nil { return false }
        
        if let string = data as? String {
            return string.isEmpty ? false : true
        }
        
        if let array = data as? Array<Any> {
            return array.isEmpty ? false : true
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



