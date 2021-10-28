//
//  RocketListCell.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 8.10.21.
//

import UIKit

class RocketListCell: UICollectionViewCell {
    
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
        firstLaunchLabel.text = buildLaunchString(for: rocket.firstLaunch)
        launchCostLabel.text = buildCostString(for: rocket.launchCost)
        successLabel.text = buildSuccessString(for: rocket.success)
    }
}


//MARK: - Private methods

private extension RocketListCell {
    
    func buildCostString(for initial: Double?) -> String? {
        let formatter = NumberFormatter()
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = ""
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.currencyGroupingSeparator = ""
        
        return "\(formatter.string(from: NSNumber(value: initial ?? .zero)) ?? "")$"
    }
    
    func buildSuccessString(for initial: Double?) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        let value = NSNumber(value: Double(initial ?? 0) / 100)
        return formatter.string(from: value)
    }
    
    func buildLaunchString(for initial: Date?) -> String? {
        guard let date = initial else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
}
