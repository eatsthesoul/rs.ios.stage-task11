//
//  LaunchDetailPresenter + CollectionViewDataSource.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 13.12.21.
//

import UIKit

extension LaunchDetailPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rocketImagesURLs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketImageCell.Constants.reuseIdentifier,
                                                      for: indexPath)

        if let cell = cell as? RocketImageCell {
            if let imageURL = rocketImagesURLs?[indexPath.row] {
                downloadManager.loadImage(for: imageURL) { image, error in
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
