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
    
    //materials
    @IBOutlet weak var materialsStackView: UIStackView!
    @IBOutlet weak var wikipediaButton: UIShadowButton!
    @IBOutlet weak var youtubeButton: UIShadowButton!
    
    //reddit
    @IBOutlet weak var redditStackView: UIStackView!
    @IBOutlet weak var recoveryButton: UIShadowButton!
    @IBOutlet weak var mediaButton: UIShadowButton!
    @IBOutlet weak var campaignButton: UIShadowButton!
    @IBOutlet weak var launchButton: UIShadowButton!
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRocketImagesCollectionView()
        setupButtons()
        setupRocketView()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    func setupButtons() {
        wikipediaButton.addTarget(self, action: #selector(showLaunchMaterial(_:)), for: .touchUpInside)
        youtubeButton.addTarget(self, action: #selector(showLaunchMaterial(_:)), for: .touchUpInside)
        recoveryButton.addTarget(self, action: #selector(showLaunchMaterial(_:)), for: .touchUpInside)
        mediaButton.addTarget(self, action: #selector(showLaunchMaterial(_:)), for: .touchUpInside)
        campaignButton.addTarget(self, action: #selector(showLaunchMaterial(_:)), for: .touchUpInside)
        launchButton.addTarget(self, action: #selector(showLaunchMaterial(_:)), for: .touchUpInside)
    }
    
    func setupRocketView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showRocketDetailModule))
        rocketView.addGestureRecognizer(tapGesture)
    }
}

//MARK: - Handlers

private extension LaunchDetailViewController {
    
    @objc func showLaunchMaterial(_ sender: UIButton) {
        
        switch sender {
        case wikipediaButton:
            output?.showLaunchMaterial(.wikipedia)
        case youtubeButton:
            output?.showLaunchMaterial(.youtube)
        case recoveryButton:
            output?.showLaunchMaterial(.redditRecovery)
        case mediaButton:
            output?.showLaunchMaterial(.redditMedia)
        case campaignButton:
            output?.showLaunchMaterial(.redditCampaign)
        case launchButton:
            output?.showLaunchMaterial(.redditLaunch)
        default:
            break
        }
    }
    
    @objc func showRocketDetailModule() {
        output?.showRocketDetailModule()
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
        
        //materials
        wikipediaButton.isHidden = !checkIfDataExist(launch.links?.wikipedia)
        youtubeButton.isHidden = !checkIfDataExist(launch.links?.youtube)
        checkIfStackViewIsVisible(materialsStackView, with: [wikipediaButton, youtubeButton])
        
        //reddit
        recoveryButton.isHidden = !checkIfDataExist(launch.links?.reddit?.recovery)
        mediaButton.isHidden = !checkIfDataExist(launch.links?.reddit?.media)
        campaignButton.isHidden = !checkIfDataExist(launch.links?.reddit?.campaign)
        launchButton.isHidden = !checkIfDataExist(launch.links?.reddit?.launch)
        checkIfStackViewIsVisible(redditStackView, with: [recoveryButton, mediaButton, campaignButton, launchButton])
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
