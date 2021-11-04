//
//  RocketListCell.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 8.10.21.
//

import UIKit

class RocketListCell: UICollectionViewCell, RocketDataDisplayable {
    
    static let reuseIdentifier = "RocketCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var firstLaunchLabel: UILabel!
    @IBOutlet weak var launchCostLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true

        layer.cornerRadius = 15
        layer.masksToBounds = false
    }
    
    func configure(with rocket: Rocket) {
        rocketNameLabel.text = rocket.name
        firstLaunchLabel.text = buildLaunchString(for: rocket)
        launchCostLabel.text = buildCostString(for: rocket)
        successLabel.text = buildSuccessString(for: rocket)
    }
}
