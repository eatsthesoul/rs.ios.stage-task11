//
//  LaunchpadListPresenter + CollectionView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21.12.21.
//

import UIKit

extension LaunchpadListPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayingLaunchpads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchpadListCollectionViewCell.Constants.reuseIdentifier,
                                                      for: indexPath)
        
        if let cell = cell as? LaunchpadListCollectionViewCell {
            //launch data
            let launchpad = displayingLaunchpads[indexPath.row]
            cell.configure(with: launchpad)
        }
        return cell
    }
}

