//
//  RocketDetailViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 01/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class RocketDetailViewController: UIViewController, RocketDetailViewInput, ModuleTransitionable {

    // MARK: - Properties

    var output: RocketDetailViewOutput?
    
    //MARK: - IBOutlets
    
    //overview
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var firstLaunchLabel: UILabel!
    @IBOutlet weak var launchCostLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    
    //images
    @IBOutlet weak var rocketImagesCollectionView: UICollectionView!
    
    //engines
    @IBOutlet weak var enginesTypeLabel: UILabel!
    @IBOutlet weak var enginesLayoutLabel: UILabel!
    @IBOutlet weak var enginesVersionLabel: UILabel!
    @IBOutlet weak var enginesAmountLabel: UILabel!
    @IBOutlet weak var enginesPropellant1Label: UILabel!
    @IBOutlet weak var enginesPropellant2Label: UILabel!
    
    //first stage
    @IBOutlet weak var firstStageReusableLabel: UILabel!
    @IBOutlet weak var firstStageEnginesAmountLabel: UILabel!
    @IBOutlet weak var firstStageFuelAmountLabel: UILabel!
    @IBOutlet weak var firstStageBurningTimeLabel: UILabel!
    @IBOutlet weak var firstStageSeaLevelThrustLabel: UILabel!
    @IBOutlet weak var firstStageVacuumThrustLabel: UILabel!
    
    //second stage
    @IBOutlet weak var secondStageReusableStageLabel: UILabel!
    @IBOutlet weak var secondStageEnginesAmountLabel: UILabel!
    @IBOutlet weak var secondStageFuelAmountLabel: UILabel!
    @IBOutlet weak var secondStageBurningTimeLabel: UILabel!
    @IBOutlet weak var secondStageThrustLabel: UILabel!
    
    //landing legs
    @IBOutlet weak var landingLegsAmountLabel: UILabel!
    @IBOutlet weak var landingLegsMaterialLabel: UILabel!
    

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - RocketDetailViewInput

}
