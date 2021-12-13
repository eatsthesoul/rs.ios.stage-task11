//
//  LaunchDetailViewController + CollectionViewDelegate.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 13.12.21.
//

import UIKit

extension LaunchDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 196)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didSelectRocketImage(with: indexPath.row)
    }
}
