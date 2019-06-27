//
//  FlowLayoutController.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 27/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

//Mark: - UICollectionViewFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //check and handle size for showing ipads logic goes here
        adjustSize()
        let paddingSize = sectionInsets.left * (itemsPerRow+1)
        let avaialbelWidth = collectionView.frame.width - paddingSize
        let widthPerItem = avaialbelWidth/itemsPerRow
        var heightMultiplier:CGFloat = 1.7
        if UIDevice.current.model == "iPad" {
            heightMultiplier = 1.6
        }
        
        return CGSize(width: widthPerItem, height: heightMultiplier*widthPerItem)
    }
    
    private func adjustSize() {
        if UIDevice.current.model == "iPhone" {
            if UIDevice.current.orientation.isLandscape {
                itemsPerRow = 3
            } else {
                itemsPerRow = 2
            }
        }
        else if UIDevice.current.model == "iPad" {
            if UIDevice.current.orientation.isLandscape {
                itemsPerRow = 4
            } else {
                itemsPerRow = 3
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
