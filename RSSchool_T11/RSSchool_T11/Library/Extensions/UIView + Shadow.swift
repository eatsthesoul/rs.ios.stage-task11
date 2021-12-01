//
//  UIView + Shadow.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 23.11.21.
//

import Foundation
import UIKit

private extension UIView {
    struct Holder {
        static var _whiteShadowLayer = CALayer()
        static var _greyShadowLayer = CALayer()
        static var _foregroundLayer = CALayer()
    }
}

extension UIView {
    
    private var whiteShadowLayer: CALayer {
        get {
            Holder._whiteShadowLayer
        }
        set(newValue) {
            Holder._whiteShadowLayer = newValue
        }
    }
    
    private var greyShadowLayer: CALayer {
        get {
            Holder._greyShadowLayer
        }
        set(newValue) {
            Holder._greyShadowLayer = newValue
        }
    }
    
    private var foregroundLayer: CALayer {
        get {
            Holder._foregroundLayer
        }
        set(newValue) {
            Holder._foregroundLayer = newValue
        }
    }
    
    func addShadow(with cornerRadius: CGFloat) {
        
        let foregroundLayer = CALayer()
        foregroundLayer.frame = bounds
        foregroundLayer.cornerRadius = cornerRadius
        foregroundLayer.backgroundColor = UIColor.smokyWhite.cgColor
        foregroundLayer.masksToBounds = true
        self.foregroundLayer = foregroundLayer
        
        let whiteShadowLayer = CALayer()
        whiteShadowLayer.shadowColor = UIColor.white.cgColor
        whiteShadowLayer.shadowOffset = CGSize(width: -2, height: -2)
        whiteShadowLayer.shadowOpacity = 1
        whiteShadowLayer.shadowRadius = 1.5
        whiteShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.whiteShadowLayer = whiteShadowLayer
        
        let greyShadowLayer = CALayer()
        greyShadowLayer.shadowColor = UIColor.shadow.cgColor
        greyShadowLayer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        greyShadowLayer.shadowOpacity = 1
        greyShadowLayer.shadowRadius = 1.5
        greyShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.greyShadowLayer = greyShadowLayer
        
        layer.insertSublayer(foregroundLayer, at: 0)
        layer.insertSublayer(whiteShadowLayer, at: 0)
        layer.insertSublayer(greyShadowLayer, at: 0)
        layer.cornerRadius = cornerRadius
    }
    
    func updateShadowPath(with cornerRadius: CGFloat) {
        foregroundLayer.frame = bounds
        foregroundLayer.cornerRadius = cornerRadius
        whiteShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        greyShadowLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.cornerRadius = cornerRadius
    }
    
    func hideShadow() {
        greyShadowLayer.shadowOpacity = 0.0
        whiteShadowLayer.shadowOpacity = 0.0
    }
    
    func appearShadow() {
        whiteShadowLayer.shadowOpacity = 1.0
        greyShadowLayer.shadowOpacity = 1.0
    }
}
