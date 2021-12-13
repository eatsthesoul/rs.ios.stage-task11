//
//  LaunchListCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 7.12.21.
//

import UIKit

class LaunchListCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        static let reuseIdentifier = "LaunchCell"
    }
    
    private lazy var launchView: UILaunchView = {
        let launchView = UILaunchView()
        launchView.layer.cornerRadius = 15
        launchView.translatesAutoresizingMaskIntoConstraints = false
        return launchView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .smokyWhite
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true

        layer.cornerRadius = 15
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.37).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 1
    }
    
    private func setupSubviews() {
        addSubview(launchView)
        NSLayoutConstraint.activate([
            launchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            launchView.topAnchor.constraint(equalTo: topAnchor),
            launchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            launchView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - API
extension LaunchListCollectionViewCell {
    
    func configure(with launch: Launch) {
        launchView.setData(for: launch)
    }
    
    func setImage(_ image: UIImage) {
        launchView.setImage(image)
    }
}
