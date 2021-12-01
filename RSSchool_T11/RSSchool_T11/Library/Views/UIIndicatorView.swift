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
        updateShadowPath(with: bounds.height / 2)
    }
    
    private func setupUI() {
        backgroundColor = .smokyWhite
        tintColor = .cyanProcess
        setupImage()
        
        addShadow(with: bounds.height / 2)
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
        switch style {
        case .complited:
            imageView.image = .checkmark
        case .expected:
            imageView.image = .clock
        }
    }

}
