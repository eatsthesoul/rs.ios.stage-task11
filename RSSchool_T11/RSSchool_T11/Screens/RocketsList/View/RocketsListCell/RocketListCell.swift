//
//  RocketListCell.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 8.10.21.
//

import UIKit

class RocketListCell: UICollectionViewCell, ModelDataDisplayable {
    
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
        
        setupLabelStackData([rocketNameLabel], with: rocket.name)
        
        let launchDateString = buildDateString(for: rocket.firstLaunch)
        setupLabelStackData([firstLaunchLabel], with: launchDateString)
        
        let launchCostString = buildCostString(for: rocket.launchCost)
        setupLabelStackData([launchCostLabel], with: launchCostString)
        
        let successString = buildSuccessString(for: rocket.success)
        setupLabelStackData([successLabel], with: successString)
    }
}
