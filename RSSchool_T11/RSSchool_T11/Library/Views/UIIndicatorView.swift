//
//  UICheckMarkView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 1.12.21.
//

import UIKit

class UIIndicatorView: UIView {
    
    enum Style {
        case complited
        case expected
    }
    
    private enum LayoutConstants {
        static let offset: CGFloat = 3
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    
    private(set) var style: Style?

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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
    }
    
    private func setupUI() {
        backgroundColor = .smokyWhite
        tintColor = .cyanProcess
        addShadow()
    }
    
    private func setupImage() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.offset),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstants.offset),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.offset),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutConstants.offset)
        ])
    }
    
    func setupStyle(_ style: Style) {
        setupImage()
        switch style {
        case .complited:
            imageView.image = .checkmark
        case .expected:
            imageView.image = .clock
        }
    }

}

// MARK: - Shadow methods
private extension UIIndicatorView {
    
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
}
