//
//  UIShadowButton.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 2.12.21.
//

import UIKit

class UIShadowButton: UIButton {
    
    private lazy var foregroundLayer: CALayer = {
        let layer = CALayer()
        layer.frame = bounds
        layer.cornerRadius = bounds.height / 2
        layer.backgroundColor = UIColor.smokyWhite.cgColor
        layer.masksToBounds = true
        return layer
    }()
    
    private lazy var whiteShadowLayer: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: -2, height: -2)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
        return layer
    }()
    
    private lazy var greyShadowLayer: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        bringSubviewToFront(imageView!)
    }
}

// MARK: - Setup methods
private extension UIShadowButton {
    
    func setupUI() {
        tintColor = .coral
        backgroundColor = .smokyWhite
        setTitleColor(.coral, for: .normal)
        setTitleColor(.champagne, for: .highlighted)
        titleLabel?.font = UIFont.roboto(17, .medium)
        semanticContentAttribute = .forceRightToLeft
        sizeToFit()
        
        setInsets()
        addShadow()
    }
    
    func setInsets() {
        let title = title(for: .normal)
        if title == nil || title == "" {
            contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        } else {
            contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
            imageEdgeInsets = .init(top: 0, left: 7.5, bottom: 0, right: 0)
        }
    }
}

// MARK: - Shadow methods
private extension UIShadowButton {
    
    func addShadow() {
        layer.insertSublayer(foregroundLayer, at: 0)
        layer.insertSublayer(whiteShadowLayer, at: 0)
        layer.insertSublayer(greyShadowLayer, at: 0)
        layer.cornerRadius = bounds.height / 2
    }
    
    func updateShadow() {
        foregroundLayer.frame = bounds
        foregroundLayer.cornerRadius = bounds.height / 2
        whiteShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
        greyShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
        layer.cornerRadius = bounds.height / 2
    }
    
    func hideShadow() {
        greyShadowLayer.shadowOpacity = 0.0
        whiteShadowLayer.shadowOpacity = 0.0
    }
    
    func appearShadow() {
        greyShadowLayer.shadowOpacity = 1.0
        whiteShadowLayer.shadowOpacity = 1.0
    }
}

