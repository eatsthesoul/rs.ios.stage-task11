//
//  LaunchListViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 30/11/2021.
//  Copyright © 2021 Evgeniy Petlitkiy. All rights reserved.
//

import UIKit

final class LaunchListViewController: UIViewController, LaunchListViewInput, ModuleTransitionable {

    // MARK: - Properties

    var output: LaunchListViewOutput?
    
    // MARK: - Private Properties

    private enum LayoutConstants {
        static let sidePadding: CGFloat = 12
    }
    
    private lazy var launchesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = output
        collectionView.register(LaunchListCollectionViewCell.self,
                                forCellWithReuseIdentifier: LaunchListCollectionViewCell.Constants.reuseIdentifier)
        return collectionView
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .queenBlue
        addSubviews()
        setupLayout()
        setupNavigationBar()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - LaunchListViewInput

    func reloadCollectionView() {
        launchesCollectionView.reloadData()
    }
}

// MARK: - Private Methods

private extension LaunchListViewController {
    
    func addSubviews() {
        view.addSubview(launchesCollectionView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            launchesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            launchesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.sidePadding),
            launchesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            launchesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.sidePadding)
        ])
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .arrowUpArrowDown, style: .plain, target: self, action: #selector(openSortingSheet))
    }
    
    @objc func openSortingSheet() {
        let sortingAlert = UIAlertController(title: "Choose your option", message: nil, preferredStyle: .actionSheet)
        sortingAlert.view.tintColor = .coral
        
        //launchDateAlertAction
        let launchDateAlertAction = UIAlertAction(title: "Launch date", style: .default) { _ in
            self.output?.sortLaunchesBy(.launchDate)
            self.launchesCollectionView.reloadData()
        }
        sortingAlert.addAction(launchDateAlertAction)
        
        //titleAlertAction
        let titleAlertAction = UIAlertAction(title: "Title", style: .default) { _ in
            self.output?.sortLaunchesBy(.title)
            self.launchesCollectionView.reloadData()
        }
        sortingAlert.addAction(titleAlertAction)
        
        //cancelAlertAction
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAlertAction.setValue(UIColor.systemRed, forKey: "titleTextColor")
        sortingAlert.addAction(cancelAlertAction)
        
        self.present(sortingAlert, animated: true, completion: nil)
    }
}
