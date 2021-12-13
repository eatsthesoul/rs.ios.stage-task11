//
//  RocketListCell.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 8.10.21.
//

import UIKit

class RocketListCell: UICollectionViewCell, ModelDataDisplayable {
    
    static let reuseIdentifier = "RocketCell"

//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var rocketNameLabel: UILabel!
//    @IBOutlet weak var firstLaunchLabel: UILabel!
//    @IBOutlet weak var launchCostLabel: UILabel!
//    @IBOutlet weak var successLabel: UILabel!
    
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
    
    private func setupSubviews() {
        addSubview(rocketView)
        NSLayoutConstraint.activate([
            rocketView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rocketView.topAnchor.constraint(equalTo: topAnchor),
            rocketView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rocketView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        bringSubviewToFront(rocketView)
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
//        contentView.layer.cornerRadius = 15
//        contentView.layer.masksToBounds = true
//
//        layer.cornerRadius = 15
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.black.withAlphaComponent(0.37).cgColor
//        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        layer.shadowRadius = 3
//        layer.shadowOpacity = 1
    }
    
    func configure(with rocket: Rocket) {
        rocketView.configure(with: rocket)
    }
    
    func setImage(_ image: UIImage) {
        rocketView.setImage(image)
    }
}
