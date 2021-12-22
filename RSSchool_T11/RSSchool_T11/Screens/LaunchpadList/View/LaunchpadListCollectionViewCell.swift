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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.roboto(24, .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.roboto(17, .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UIShadowLabelView = {
        let view = UIShadowLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    func setupSubviews() {
        addSubview(nameLabel)
        addSubview(regionLabel)
        addSubview(statusLabel)
        
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 145),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            
            regionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            regionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            regionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            statusLabel.topAnchor.constraint(greaterThanOrEqualTo: regionLabel.bottomAnchor, constant: 10),
            statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -23),
            statusLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
        ])
    }
}

// MARK: - API
extension LaunchpadListCollectionViewCell: ModelDataDisplayable {
    
    func configure(with launchpad: Launchpad) {
        setupLabelStackData([nameLabel], with: launchpad.name)
        setupLabelStackData([regionLabel], with: launchpad.region)
        
        statusLabel.setText(launchpad.status)
    }
}
