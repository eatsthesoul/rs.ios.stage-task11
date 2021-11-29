//
//  CloseButton.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 25.11.21.
//

import UIKit

class CloseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func setupUI(){
        tintColor = .coral
        backgroundColor = .smokyWhite
        layer.cornerRadius = bounds.height / 2
        
        setImage(.xmark, for: .normal)
        bringSubviewToFront(imageView!)
        
        contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        addShadow(with: bounds.height / 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath(with: bounds.height / 2)
        layer.cornerRadius = bounds.height / 2
    }
    
    override var isHighlighted: Bool {
        willSet {
            if newValue {
                tintColor = .champagne
                imageView?.tintColor = .champagne
                hideShadow()
            } else {
                tintColor = .coral
                imageView?.tintColor = .coral
                appearShadow()
            }
        }
    }

}
