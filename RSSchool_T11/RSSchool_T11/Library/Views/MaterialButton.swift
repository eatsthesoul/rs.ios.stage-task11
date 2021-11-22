//
//  MaterialButton.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 19.11.21.
//

import UIKit

class MaterialButton: UIButton {
    
    private lazy var whiteShadowLayer: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: -2, height: -2)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        return layer
    }()
    
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
        
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        
        layer.insertSublayer(whiteShadowLayer, at: 0)
        
        contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 12.5)
        imageEdgeInsets = .init(top: 0, left: 7.5, bottom: 0, right: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: frame.height / 2).cgPath
        whiteShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: frame.height / 2).cgPath
        layer.cornerRadius = frame.height / 2
    }
    
    
    override var isHighlighted: Bool {
        willSet {
            if newValue {
                tintColor = .champagne
                imageView?.tintColor = .champagne
                layer.shadowOpacity = 0.0
            } else {
                tintColor = .coral
                imageView?.tintColor = .coral
                layer.shadowOpacity = 1.0
            }
        }
    }
}
