//
//  MainViewPresenter + CollectionView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 26.10.21.
//

import UIKit

extension RocketListPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayingRockets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketListCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? RocketListCell {
            
            //rocket data
            let rocket = displayingRockets[indexPath.row]
            cell.configure(with: rocket)
            
            //rocket image
            if let imageURL = rocket.images?.first {
                service.imageService.loadImage(for: imageURL) { image, error in
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
