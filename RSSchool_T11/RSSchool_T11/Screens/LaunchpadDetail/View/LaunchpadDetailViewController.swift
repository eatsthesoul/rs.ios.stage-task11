//
//  LaunchpadDetailViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21/12/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit
import MapKit

final class LaunchpadDetailViewController: UIViewController, ModuleTransitionable {

    // MARK: - Properties

    var output: LaunchpadDetailViewOutput?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var statusLabelView: UIShadowLabelView!
    
    @IBOutlet weak var descriptionStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var overviewStackView: UIStackView!
    @IBOutlet weak var regionTitleLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var launchAttemptsTitleLabel: UILabel!
    @IBOutlet weak var launchAttemptsLabel: UILabel!
    @IBOutlet weak var launchSuccessTitleLabel: UILabel!
    @IBOutlet weak var launchSuccessLabel: UILabel!
    
    //images
    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    //location
    @IBOutlet weak var locationStackView: UIStackView!
    @IBOutlet weak var mapView: MapView!
    
    //materials
    @IBOutlet weak var materialsStackView: UIStackView!
    @IBOutlet weak var rocketsButton: UIShadowButton!
    @IBOutlet weak var launchesButton: UIShadowButton!
    

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .smokyWhite
        setupSubviews()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - LaunchpadDetailViewInput

}

// MARK: - LaunchDetailViewInput
extension LaunchpadDetailViewController: LaunchpadDetailViewInput, ModelDataDisplayable {
    
    func setup(with launchpad: Launchpad) {
        nameLabel.text = launchpad.name
        fullNameLabel.text = launchpad.fullName
        
        statusLabelView.isHidden = !checkIfDataExist(launchpad.status)
        statusLabelView.setText(launchpad.status)
        
        //description
        setupLabelStackData([descriptionLabel], with: launchpad.details)
        checkIfStackViewIsVisible(descriptionStackView, with: [descriptionLabel])
        
        //overview
        let launchAttemptsString = buildAmountString(for: launchpad.launchAttempts)
        let launchSuccessesString = buildAmountString(for: launchpad.launchSuccesses)
        setupLabelStackData([regionLabel, regionTitleLabel], with: launchpad.region)
        setupLabelStackData([locationLabel, locationTitleLabel], with: launchpad.locality)
        setupLabelStackData([launchAttemptsLabel, launchAttemptsTitleLabel], with: launchAttemptsString)
        setupLabelStackData([launchSuccessLabel, launchSuccessTitleLabel], with: launchSuccessesString)
        checkIfStackViewIsVisible(overviewStackView, with: [regionLabel, locationLabel, launchAttemptsLabel, launchSuccessLabel])
        
        //images
        imagesCollectionView.isHidden = !checkIfDataExist(launchpad.images?.large)
        checkIfStackViewIsVisible(imagesStackView, with: [imagesCollectionView])
        
        //location
        setupMapViewWith(latitude: launchpad.latitude, longitude: launchpad.longitude, title: launchpad.locality)
        
        //materials
        rocketsButton.isHidden = !checkIfDataExist(launchpad.rockets)
        launchesButton.isHidden = !checkIfDataExist(launchpad.launches)
        checkIfStackViewIsVisible(materialsStackView, with: [rocketsButton, launchesButton])
    }
}

// MARK: - Private methods
private extension LaunchpadDetailViewController {
    
    func setupSubviews() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = output
        imagesCollectionView.register(ImageCell.self,
                                            forCellWithReuseIdentifier: ImageCell.Constants.reuseIdentifier)
        
        rocketsButton.addTarget(self, action: #selector(showLaunchpadMaterial(_:)), for: .touchUpInside)
        launchesButton.addTarget(self, action: #selector(showLaunchpadMaterial(_:)), for: .touchUpInside)
    }
    
    func setupMapViewWith(latitude: Double?, longitude: Double?, title: String?) {
        
        guard let latitude = latitude, let longitude = longitude else {
            locationStackView.isHidden = true
            return
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.mapView.addAnnotation(annotation)
    }
    
    @objc func showLaunchpadMaterial(_ sender: UIButton) {
        switch sender {
        case rocketsButton:
            output?.showLaunchMaterial(.rockets)
        case launchesButton:
            output?.showLaunchMaterial(.launches)
        default:
            break
        }
    }
}
