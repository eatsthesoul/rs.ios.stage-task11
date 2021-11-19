//
//  RocketDetailViewCell.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 16.11.21.
//

import UIKit

class RocketDetailViewCell: UICollectionViewCell {
    
    enum Constants {
        static let reuseIdentifier = "RocketImageCell"
    }
    
    private enum LayoutConstants {
        static let imageViewPadding: CGFloat = 3
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let shadowLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowLayer.frame = layer.bounds
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        shadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        layer.shadowRadius = 1.5
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowColor = UIColor.shadow.cgColor
        layer.borderColor = UIColor.smokyWhite.cgColor
        layer.borderWidth = 3
        
        shadowLayer.shadowColor = UIColor.white.cgColor
        shadowLayer.cornerRadius = 10
        shadowLayer.opacity = 1.0
        shadowLayer.shadowRadius = 1.5
        shadowLayer.masksToBounds = false
        shadowLayer.needsDisplayOnBoundsChange = true
        shadowLayer.shadowOffset = CGSize(width: -1, height: -1)
        layer.insertSublayer(shadowLayer, at: 1)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
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
