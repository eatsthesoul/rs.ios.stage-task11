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
        static let cornerRadius: CGFloat = 10
        static let imageCornerRadius: CGFloat = 7
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
        updateShadowPath(with: LayoutConstants.cornerRadius)
    }
    
    private func setupUI() {
        addShadow(with: LayoutConstants.cornerRadius)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = LayoutConstants.imageCornerRadius
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
