//
//  RocketDetailPresenter + CollectionView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 16.11.21.
//

import UIKit

extension RocketDetailPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rocket?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketImageCell.Constants.reuseIdentifier,
                                                      for: indexPath)

        if let cell = cell as? RocketImageCell {
            if let imageURL = rocket?.images?[indexPath.row] {
                networkService.imageService.loadImage(for: imageURL) { image, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    guard let image = image else { return }
                    cell.imageView.image = image
                }
            }
        }
        return cell
    }
    
    
}
