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
        setupNavigationBar()
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .arrowUpArrowDown, style: .plain, target: self, action: #selector(openSortingSheet))
    }
    
    @objc func openSortingSheet() {
        let sortingAlert = UIAlertController(title: "Choose your option", message: nil, preferredStyle: .actionSheet)
        sortingAlert.view.tintColor = .coral
        
        //titleAlertAction
        let titleAlertAction = UIAlertAction(title: "Title", style: .default) { _ in
            self.output?.sortLaunchpadsBy(.title)
            self.launchpadsCollectionView.reloadData()
        }
        sortingAlert.addAction(titleAlertAction)
        
        //regionAlertAction
        let regionAlertAction = UIAlertAction(title: "Region", style: .default) { _ in
            self.output?.sortLaunchpadsBy(.region)
            self.launchpadsCollectionView.reloadData()
        }
        sortingAlert.addAction(regionAlertAction)
        
        //statusAlertAction
        let statusAlertAction = UIAlertAction(title: "Status", style: .default) { _ in
            self.output?.sortLaunchpadsBy(.status)
            self.launchpadsCollectionView.reloadData()
        }
        sortingAlert.addAction(statusAlertAction)
        
        //cancelAlertAction
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAlertAction.setValue(UIColor.systemRed, forKey: "titleTextColor")
        sortingAlert.addAction(cancelAlertAction)
        
        self.present(sortingAlert, animated: true, completion: nil)
    }
}
