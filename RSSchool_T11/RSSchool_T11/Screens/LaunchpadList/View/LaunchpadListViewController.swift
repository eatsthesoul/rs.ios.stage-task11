//
//  LaunchpadListViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21.12.21.
//

import UIKit

final class LaunchpadListViewController: UIViewController, LaunchpadListViewInput, ModuleTransitionable {
    
    var output: LaunchpadListViewOutput?
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .queenBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
