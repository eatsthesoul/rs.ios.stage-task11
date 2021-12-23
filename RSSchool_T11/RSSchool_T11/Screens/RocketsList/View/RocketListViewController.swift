//
//  RocketListViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 28/09/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class RocketListViewController: UIViewController, RocketListViewInput, ModuleTransitionable {

    // MARK: - Properties

    var output: RocketListViewOutput?
    
    //MARK: - Private Properties
    
    private enum LayoutConstants {
        static let sidePadding: CGFloat = 12
    }
    
    private lazy var rocketsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = output
        collectionView.register(RocketListCell.self, forCellWithReuseIdentifier: RocketListCell.reuseIdentifier)
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
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - RocketsListViewInput
    
    func reloadCollectionView() {
        rocketsCollectionView.reloadData()
    }
}

// MARK: - Private Methods

private extension RocketListViewController {
    private func addSubviews() {
        view.addSubview(rocketsCollectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            rocketsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rocketsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.sidePadding),
            rocketsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rocketsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.sidePadding)
        ])
    }
}
