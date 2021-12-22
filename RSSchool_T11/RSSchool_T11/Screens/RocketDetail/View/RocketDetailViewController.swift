//
//  RocketDetailViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class RocketDetailViewController: UIViewController, RocketDetailViewInput, ModuleTransitionable, ModelDataDisplayable {

    // MARK: - Properties
    
    private var isImageURLsExist = false
    
    var output: RocketDetailViewOutput?
    
    //MARK: - IBOutlets
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var rocketNameLabel: UILabel!
    
    //description
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //overview
    @IBOutlet weak var firstLaunchTitleLabel: UILabel!
    @IBOutlet weak var firstLaunchLabel: UILabel!
    @IBOutlet weak var launchCostTitleLabel: UILabel!
    @IBOutlet weak var launchCostLabel: UILabel!
    @IBOutlet weak var successTitleLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var massTitleLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var heightTitleLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var diameterTitleLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    
    //images
    @IBOutlet weak var rocketImagesStackView: UIStackView!
    @IBOutlet weak var rocketImagesCollectionView: UICollectionView!
    
    //engines
    @IBOutlet weak var enginesTypeTitleLabel: UILabel!
    @IBOutlet weak var enginesTypeLabel: UILabel!
    @IBOutlet weak var enginesLayoutTitleLabel: UILabel!
    @IBOutlet weak var enginesLayoutLabel: UILabel!
    @IBOutlet weak var enginesVersionTitleLabel: UILabel!
    @IBOutlet weak var enginesVersionLabel: UILabel!
    @IBOutlet weak var enginesAmountTitleLabel: UILabel!
    @IBOutlet weak var enginesAmountLabel: UILabel!
    @IBOutlet weak var enginesPropellant1TitleLabel: UILabel!
    @IBOutlet weak var enginesPropellant1Label: UILabel!
    @IBOutlet weak var enginesPropellant2TitleLabel: UILabel!
    @IBOutlet weak var enginesPropellant2Label: UILabel!
    
    //first stage
    @IBOutlet weak var firstStageReusableTitleLabel: UILabel!
    @IBOutlet weak var firstStageReusableLabel: UILabel!
    @IBOutlet weak var firstStageEnginesAmountTitleLabel: UILabel!
    @IBOutlet weak var firstStageEnginesAmountLabel: UILabel!
    @IBOutlet weak var firstStageFuelAmountTitleLabel: UILabel!
    @IBOutlet weak var firstStageFuelAmountLabel: UILabel!
    @IBOutlet weak var firstStageBurningTimeTitleLabel: UILabel!
    @IBOutlet weak var firstStageBurningTimeLabel: UILabel!
    @IBOutlet weak var firstStageSeaLevelThrustTitleLabel: UILabel!
    @IBOutlet weak var firstStageSeaLevelThrustLabel: UILabel!
    @IBOutlet weak var firstStageVacuumThrustTitleLabel: UILabel!
    @IBOutlet weak var firstStageVacuumThrustLabel: UILabel!
    
    //second stage
    @IBOutlet weak var secondStageReusableStageTitleLabel: UILabel!
    @IBOutlet weak var secondStageReusableStageLabel: UILabel!
    @IBOutlet weak var secondStageEnginesAmountTitleLabel: UILabel!
    @IBOutlet weak var secondStageEnginesAmountLabel: UILabel!
    @IBOutlet weak var secondStageFuelAmountTitleLabel: UILabel!
    @IBOutlet weak var secondStageFuelAmountLabel: UILabel!
    @IBOutlet weak var secondStageBurningTimeTitleLabel: UILabel!
    @IBOutlet weak var secondStageBurningTimeLabel: UILabel!
    @IBOutlet weak var secondStageThrustTitleLabel: UILabel!
    @IBOutlet weak var secondStageThrustLabel: UILabel!
    
    //landing legs
    @IBOutlet weak var landingLegsAmountTitleLabel: UILabel!
    @IBOutlet weak var landingLegsAmountLabel: UILabel!
    @IBOutlet weak var landingLegsMaterialTitleLabel: UILabel!
    @IBOutlet weak var landingLegsMaterialLabel: UILabel!
    
    //materials
    @IBOutlet weak var materialsStackView: UIStackView!
    @IBOutlet weak var wikiButton: UIShadowButton!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - Private methods
extension RocketDetailViewController {
    
    private func setupViews() {
        
        wikiButton.addTarget(self, action: #selector(showRocketMaterial(_:)), for: .touchUpInside)
        
        rocketImagesCollectionView.register(ImageCell.self,
                                            forCellWithReuseIdentifier: ImageCell.Constants.reuseIdentifier)
        rocketImagesCollectionView.delegate = self
        rocketImagesCollectionView.dataSource = output
    }
}

// MARK: - RocketDetailViewInput
extension RocketDetailViewController {
    
    func setup(with rocket: Rocket) {
        
        setupLabelStackData([rocketNameLabel], with: rocket.name)
        setupLabelStackData([descriptionLabel, descriptionTitleLabel], with: rocket.description)
        
        //overview
        let launchDateString = buildDateString(for: rocket.firstLaunch)
        let launchCostString = buildCostString(for: rocket.launchCost)
        let successString = buildSuccessString(for: rocket.success)
        let massString = buildMassString(for: rocket.mass)
        let heightString = buildSizeString(for: rocket.height)
        let diameterString = buildSizeString(for: rocket.diameter)
        
        setupLabelStackData([firstLaunchLabel, firstLaunchTitleLabel], with: launchDateString)
        setupLabelStackData([launchCostLabel, launchCostTitleLabel], with: launchCostString)
        setupLabelStackData([successLabel, successTitleLabel], with: successString)
        setupLabelStackData([massLabel, massTitleLabel], with: massString)
        setupLabelStackData([heightLabel, heightTitleLabel], with: heightString)
        setupLabelStackData([diameterLabel, diameterTitleLabel], with: diameterString)

        
        //engines
        let enginesAmountString = buildAmountString(for: rocket.engines?.number)
        
        setupLabelStackData([enginesTypeLabel, enginesTypeTitleLabel], with: rocket.engines?.type)
        setupLabelStackData([enginesLayoutLabel, enginesLayoutTitleLabel], with: rocket.engines?.layout)
        setupLabelStackData([enginesVersionLabel, enginesVersionTitleLabel], with: rocket.engines?.version)
        setupLabelStackData([enginesAmountLabel, enginesAmountTitleLabel], with: enginesAmountString)
        setupLabelStackData([enginesPropellant1Label, enginesPropellant1TitleLabel], with: rocket.engines?.propellant1)
        setupLabelStackData([enginesPropellant2Label, enginesPropellant2TitleLabel], with: rocket.engines?.propellant2)
        
        
        //first stage
        let firstStageReusableString = buildBoolString(for: rocket.firstStage?.reusable)
        let firstStageEnginesAmountString = buildAmountString(for: rocket.firstStage?.engines)
        let firstStageFuelAmountString = buildFuelAmountString(for: rocket.firstStage?.fuelAmount)
        let firstStageBurningTimeString = buildBurningTimeString(for: rocket.firstStage?.burningTime)
        let firstStageSeaLevelThrustString = buildThrustLevelString(for: rocket.firstStage?.thrustSeaLevel)
        let firstStageVacuumThrustString = buildThrustLevelString(for: rocket.firstStage?.thrustVacuum)
        
        setupLabelStackData([firstStageReusableLabel, firstStageReusableTitleLabel], with: firstStageReusableString)
        setupLabelStackData([firstStageEnginesAmountLabel, firstStageEnginesAmountTitleLabel], with: firstStageEnginesAmountString)
        setupLabelStackData([firstStageFuelAmountLabel, firstStageFuelAmountTitleLabel], with: firstStageFuelAmountString)
        setupLabelStackData([firstStageBurningTimeLabel, firstStageBurningTimeTitleLabel], with: firstStageBurningTimeString)
        setupLabelStackData([firstStageSeaLevelThrustLabel, firstStageSeaLevelThrustTitleLabel], with: firstStageSeaLevelThrustString)
        setupLabelStackData([firstStageVacuumThrustLabel, firstStageVacuumThrustTitleLabel], with: firstStageVacuumThrustString)
        
        
        //second stage
        let secondStageReusableString = buildBoolString(for: rocket.secondStage?.reusable)
        let secondStageEnginesAmountString = buildAmountString(for: rocket.secondStage?.engines)
        let secondStageFuelAmountString = buildFuelAmountString(for: rocket.secondStage?.fuelAmount)
        let secondStageBurningTimeString = buildBurningTimeString(for: rocket.secondStage?.burningTime)
        let secondStageThrustString = buildThrustLevelString(for: rocket.secondStage?.thrust)
        
        setupLabelStackData([secondStageReusableStageLabel, secondStageReusableStageTitleLabel], with: secondStageReusableString)
        setupLabelStackData([secondStageEnginesAmountLabel, secondStageEnginesAmountTitleLabel], with: secondStageEnginesAmountString)
        setupLabelStackData([secondStageFuelAmountLabel, secondStageFuelAmountTitleLabel], with: secondStageFuelAmountString)
        setupLabelStackData([secondStageBurningTimeLabel, secondStageBurningTimeTitleLabel], with: secondStageBurningTimeString)
        setupLabelStackData([secondStageThrustLabel, secondStageThrustTitleLabel], with: secondStageThrustString)
        
        
        //landing legs
        let landingLegsAmountString = buildAmountString(for: rocket.landingLegs?.amount)
        
        setupLabelStackData([landingLegsAmountLabel, landingLegsAmountTitleLabel], with: landingLegsAmountString)
        setupLabelStackData([landingLegsMaterialLabel, landingLegsMaterialTitleLabel], with: rocket.landingLegs?.material)
        
        //materials
        wikiButton.isHidden = !checkIfDataExist(rocket.wikipedia)
        checkIfStackViewIsVisible(materialsStackView, with: [wikiButton])
    }
    
    func reloadRocketImages() {
        rocketImagesCollectionView.reloadData()
        rocketImagesStackView.isHidden = false
    }
    
    func hideRocketImages() {
        rocketImagesStackView.isHidden = true
    }
    
    func setupRocketCoverImage(_ image: UIImage) {
        UIView.transition(with: coverImage, duration: 0.4, options: .curveEaseInOut, animations: {
            self.coverImage.image = image
        }, completion: nil)
    }
}

// MARK: - Link Buttons methods

private extension RocketDetailViewController {
    
    @objc func showRocketMaterial(_ sender: UIButton) {
        
        switch sender {
        case wikiButton:
            output?.showRocketMaterial(.wikipedia)
        default:
            break
        }
    }
}
