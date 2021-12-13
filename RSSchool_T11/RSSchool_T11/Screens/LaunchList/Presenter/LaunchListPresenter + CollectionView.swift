//
//  LaunchListPresenter + CollectionView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 7.12.21.
//

import UIKit

extension LaunchListPresenter: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchListCollectionViewCell.Constants.reuseIdentifier,
                                                      for: indexPath)
        
        if let cell = cell as? LaunchListCollectionViewCell {
            
            //launch data
            let launch = launches[indexPath.row]
            cell.configure(with: launch)
            
            //launch image
            if let imageURL = launch.links?.patch?.small {
                downloadManager.loadImage(for: imageURL) { image, error in
                    if let err = error {
                        print(err)
                        return
                    }
                    guard let img = image else { return }
                    cell.setImage(img)
                }
            }
        }
        return cell
    }
    
    
    
}
