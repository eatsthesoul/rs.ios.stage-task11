//
//  LaunchpadListViewController + CollectionView.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 21.12.21.
//

import UIKit

// MARK: - UICollectionViewDelegate

extension LaunchpadListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        output?.didSelectLaunch(with: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LaunchpadListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - (18 * 2)
        let height: CGFloat = 140
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
    }
}
