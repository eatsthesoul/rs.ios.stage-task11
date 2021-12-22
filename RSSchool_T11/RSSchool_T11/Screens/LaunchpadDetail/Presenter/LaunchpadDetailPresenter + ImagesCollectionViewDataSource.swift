//
//  LaunchpadDetailPresenter + ImagesCollectionViewDataSource.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 22.12.21.
//

import Foundation
import UIKit

extension LaunchpadDetailPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launchpad?.images?.large?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.Constants.reuseIdentifier,
                                                      for: indexPath)

        if let cell = cell as? ImageCell {
            if let imageURL = launchpad?.images?.large?[indexPath.row] {
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
