//
//  LaunchpadListViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21.12.21.
//

import UIKit

final class LaunchpadListViewController: UIViewController, LaunchpadListViewInput, ModuleTransitionable {
    
    var output: LaunchpadListViewOutput?
    
    private enum LayoutConstants {
        static let sidePadding: CGFloat = 12
    }
    
    private lazy var launchpadsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = output
        collectionView.register(LaunchpadListCollectionViewCell.self,
                                forCellWithReuseIdentifier: LaunchpadListCollectionViewCell.Constants.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .queenBlue
        addSubviews()
        setupLayout()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - LaunchpadListViewInput

    func reloadCollectionView() {
        launchpadsCollectionView.reloadData()
    }
}

// MARK: - Private Methods

private extension LaunchpadListViewController {
    
    func addSubviews() {
        view.addSubview(launchpadsCollectionView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            launchpadsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            launchpadsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.sidePadding),
            launchpadsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            launchpadsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.sidePadding)
        ])
    }
}
