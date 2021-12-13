//
//  RocketListCell.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 8.10.21.
//

import UIKit

class RocketListCell: UICollectionViewCell, ModelDataDisplayable {
    
    static let reuseIdentifier = "RocketCell"
    
    private lazy var rocketView: UIRocketView = {
        let rocketView = UIRocketView()
        rocketView.translatesAutoresizingMaskIntoConstraints = false
        return rocketView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
        setupUI()
    }
}

private extension RocketListCell {
    
    func setupSubviews() {
        addSubview(rocketView)
        NSLayoutConstraint.activate([
            rocketView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rocketView.topAnchor.constraint(equalTo: topAnchor),
            rocketView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rocketView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        bringSubviewToFront(rocketView)
    }
    
    func setupUI() {
        backgroundColor = .clear
    }
}

//MARK: - API

extension RocketListCell {
    func configure(with rocket: Rocket) {
        rocketView.configure(with: rocket)
    }
    
    func setImage(_ image: UIImage) {
        rocketView.setImage(image)
    }
}
