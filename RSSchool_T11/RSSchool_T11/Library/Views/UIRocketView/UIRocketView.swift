//
//  UIRocketView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 8.12.21.
//

import UIKit

class UIRocketView: UIView {
    
    private let nibName = "UIRocketView"
    private var contentView: UIView?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var firstLaunchLabel: UILabel!
    @IBOutlet weak var launchCostLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNibView()
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNibView()
    }
}

// MARK: - Private methods
private extension UIRocketView {
    
    func setupNibView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        contentView = view
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView!)
        NSLayoutConstraint.activate([
            contentView!.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView!.topAnchor.constraint(equalTo: topAnchor),
            contentView!.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView!.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setupUI() {
        layer.backgroundColor = UIColor.smokyWhite.cgColor
        layer.cornerRadius = 15
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.37).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 1
        
        contentView?.backgroundColor = .smokyWhite
        contentView?.layer.cornerRadius = 15
        contentView?.layer.masksToBounds = true
    }
}

// MARK: - API
extension UIRocketView: ModelDataDisplayable {
    
    func configure(with rocket: Rocket) {
        
        setupLabelStackData([rocketNameLabel], with: rocket.name)
        
        let launchDateString = buildDateString(for: rocket.firstLaunch)
        setupLabelStackData([firstLaunchLabel], with: launchDateString)
        
        let launchCostString = buildCostString(for: rocket.launchCost)
        setupLabelStackData([launchCostLabel], with: launchCostString)
        
        let successString = buildSuccessString(for: rocket.success)
        setupLabelStackData([successLabel], with: successString)
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
