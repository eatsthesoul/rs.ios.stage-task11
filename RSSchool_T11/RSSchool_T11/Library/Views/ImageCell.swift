//
//  RocketDetailViewCell.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 16.11.21.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    enum Constants {
        static let reuseIdentifier = "ImageCell"
    }
    
    private enum LayoutConstants {
        static let imageViewPadding: CGFloat = 3
        static let cornerRadius: CGFloat = 10
        static let imageCornerRadius: CGFloat = 7
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = LayoutConstants.imageCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foregroundLayer: CALayer = {
        let layer = CALayer()
        layer.frame = bounds
        layer.cornerRadius = LayoutConstants.cornerRadius
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
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: LayoutConstants.cornerRadius).cgPath
        return layer
    }()
    
    private lazy var greyShadowLayer: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: LayoutConstants.cornerRadius).cgPath
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.imageViewPadding),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstants.imageViewPadding),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.imageViewPadding),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutConstants.imageViewPadding)
        ])
    }
}

// MARK: - Shadow methods
private extension ImageCell {
    
    func addShadow() {
         layer.insertSublayer(foregroundLayer, at: 0)
         layer.insertSublayer(whiteShadowLayer, at: 0)
         layer.insertSublayer(greyShadowLayer, at: 0)
         layer.cornerRadius = LayoutConstants.cornerRadius
     }
     
    func updateShadowPath() {
         foregroundLayer.frame = bounds
        foregroundLayer.cornerRadius = LayoutConstants.cornerRadius
         whiteShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: LayoutConstants.cornerRadius).cgPath
         greyShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: LayoutConstants.cornerRadius).cgPath
         layer.cornerRadius = bounds.height / 2
     }
}
