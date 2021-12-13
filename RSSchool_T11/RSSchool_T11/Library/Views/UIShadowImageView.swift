//
//  UIShadowImageView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 6.12.21.
//

import UIKit

class UIShadowImageView: UIView {
    
    private enum Constants {
        static let horizontalInset: CGFloat = 9.5
        static let verticalInset: CGFloat = 15
        static let imageHeight: CGFloat = 80
        static let imageWidth: CGFloat = 91
        static let cornerRadius: CGFloat = 20
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.startAnimating()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()

    private lazy var foregroundLayer: CALayer = {
        let layer = CALayer()
        layer.frame = bounds
        layer.cornerRadius = Constants.cornerRadius
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
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: Constants.cornerRadius).cgPath
        return layer
    }()
    
    private lazy var greyShadowLayer: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: Constants.cornerRadius).cgPath
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

private extension UIShadowImageView {
    func setupUI() {
        backgroundColor = .smokyWhite
        setupSubviews()
        addShadow()
    }
    
    func setupSubviews() {
        addSubview(imageView)
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalInset),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalInset),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalInset),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalInset),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}


// MARK: - API
extension UIShadowImageView {
    
    func setImage(_ image: UIImage) {
        activityIndicator.stopAnimating()
        imageView.image = image
    }
}

// MARK: - Shadow methods
private extension UIShadowImageView {
    
    func addShadow() {
        layer.insertSublayer(foregroundLayer, at: 0)
        layer.insertSublayer(whiteShadowLayer, at: 0)
        layer.insertSublayer(greyShadowLayer, at: 0)
        layer.cornerRadius = Constants.cornerRadius
    }
    
    func updateShadow() {
        foregroundLayer.frame = bounds
        foregroundLayer.cornerRadius = Constants.cornerRadius
        whiteShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: Constants.cornerRadius).cgPath
        greyShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: Constants.cornerRadius).cgPath
        layer.cornerRadius = Constants.cornerRadius
    }
}
