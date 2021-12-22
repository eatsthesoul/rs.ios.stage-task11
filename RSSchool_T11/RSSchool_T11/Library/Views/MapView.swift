//
//  MapView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 22.12.21.
//

import UIKit
import MapKit

class MapView: UIView {
    
    private enum LayoutConstants {
        static let mapViewPadding: CGFloat = 5
        static let cornerRadius: CGFloat = 20
        static let mapViewCornerRadius: CGFloat = 16
    }
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.layer.cornerRadius = LayoutConstants.mapViewCornerRadius
        view.layer.masksToBounds = true
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
        setupMapView()
        addShadow()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMapView()
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
    }
}

// MARK: - Private methods
private extension MapView {
    
    func setupMapView() {
        addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.mapViewPadding),
            mapView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstants.mapViewPadding),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.mapViewPadding),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutConstants.mapViewPadding)
        ])
    }
}

// MARK: - Shadow methods
private extension MapView {
    
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
