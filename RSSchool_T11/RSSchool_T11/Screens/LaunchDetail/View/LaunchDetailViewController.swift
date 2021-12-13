//
//  LaunchDetailViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 08/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class LaunchDetailViewController: UIViewController, LaunchDetailViewInput, ModuleTransitionable {

    // MARK: - Properties

    var output: LaunchDetailViewOutput?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var launchView: UILaunchView!
    
    //description
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //overview
    @IBOutlet weak var staticFireDateTitleLabel: UILabel!
    @IBOutlet weak var staticFireDateLabel: UILabel!
    @IBOutlet weak var launchDateTitleLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var successTitleLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    
    
    @IBOutlet weak var rocketImagesStackView: UIStackView!
    @IBOutlet weak var rocketImagesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var rocketStackView: UIStackView!
    @IBOutlet weak var rocketView: UIRocketView!
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRocketImagesCollectionView()
        output?.viewDidLoad()
    }
}

//MARK: - Private methods

private extension LaunchDetailViewController {
    
    func setupRocketImagesCollectionView() {
        rocketImagesCollectionView.delegate = self
        rocketImagesCollectionView.dataSource = output
        rocketImagesCollectionView.register(RocketImageCell.self,
                                            forCellWithReuseIdentifier: RocketImageCell.Constants.reuseIdentifier)
    }
}

// MARK: - LaunchDetailViewInput

extension LaunchDetailViewController {
    
    func setup(with launch: Launch) {
        
        //launch view
        launchView.setData(for: launch)
        
        //description
        setupLabelStackData([descriptionLabel, descriptionTitleLabel], with: launch.details)
        
        //overview
        let staticFireDateString = buildDateString(for: launch.staticFireDate)
        let launchDateString = buildDateString(for: launch.launchDate)
        let successString = buildBoolString(for: launch.success)
        
        setupLabelStackData([staticFireDateLabel, staticFireDateTitleLabel], with: staticFireDateString)
        setupLabelStackData([launchDateLabel, launchDateTitleLabel], with: launchDateString)
        setupLabelStackData([successLabel, successTitleLabel], with: successString)
    }
    
    func setCoverImage(_ image: UIImage) {
        launchView.setImage(image)
    }
    
    func setupRocketView(with rocket: Rocket?) {
        guard let rocket = rocket else {
            rocketStackView.isHidden = true
            return
        }
        rocketView.configure(with: rocket)
    }
    
    func setRocketViewCoverImage(_ image: UIImage) {
        rocketView.setImage(image)
    }
    
    func reloadRocketImages() {
        rocketImagesCollectionView.reloadData()
        rocketImagesStackView.isHidden = false
    }
    
    func hideRocketImages() {
        rocketImagesStackView.isHidden = true
    }
}
