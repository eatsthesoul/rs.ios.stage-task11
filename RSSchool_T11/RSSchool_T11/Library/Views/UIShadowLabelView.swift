//
//  UIShadowView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 6.12.21.
//

import UIKit

class UIShadowLabelView: UIView {
    
    private enum LayoutConstants {
        static let horizontalInset: CGFloat = 10
        static let verticalInset: CGFloat = 5
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .cyanProcess
        label.font = UIFont.roboto(17, .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

}

// MARK: - Private methods
private extension UIShadowLabelView {
    
    func setupUI() {
        backgroundColor = .smokyWhite
        addShadow()
    }
    
    func setupLabel() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.horizontalInset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstants.verticalInset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.horizontalInset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutConstants.verticalInset),
        ])
    }
}

// MARK: - API
extension UIShadowLabelView {
    func setText(_ text: String) {
        setupLabel()
        self.label.text = text
    }
}

// MARK: - Shadow methods
private extension UIShadowLabelView {
    
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
