//
//  MaterialButton.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 19.11.21.
//

import UIKit

class MaterialButton: UIButton {
    
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
        setTitleColor(.coral, for: .normal)
        setTitleColor(.champagne, for: .highlighted)
        titleLabel?.font = UIFont(name: "Roboto-Medium", size: 17)
        semanticContentAttribute = .forceRightToLeft
        sizeToFit()
        
        contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 12.5)
        imageEdgeInsets = .init(top: 0, left: 7.5, bottom: 0, right: 0)
        
        addShadow(with: bounds.height / 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath(with: bounds.height / 2)
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
