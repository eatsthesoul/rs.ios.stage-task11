//
//  LaunchpadListCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21.12.21.
//

import UIKit


class LaunchpadListCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        static let reuseIdentifier = "LaunchpadCell"
    }
    
    private lazy var launchpadView: UILaunchpadView = {
        let launchView = UILaunchpadView()
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
        addSubview(launchpadView)
        NSLayoutConstraint.activate([
            launchpadView.leadingAnchor.constraint(equalTo: leadingAnchor),
            launchpadView.topAnchor.constraint(equalTo: topAnchor),
            launchpadView.trailingAnchor.constraint(equalTo: trailingAnchor),
            launchpadView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - API
extension LaunchpadListCollectionViewCell {
    
    func configure(with launchpad: Launchpad) {
        launchpadView.setData(for: launchpad)
    }
}
