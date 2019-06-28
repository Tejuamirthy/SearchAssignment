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
        /// handling size and showing items on ipads logic goes here
        adjustSize()
        let paddingSize = sectionInsets.left * (itemsPerRow + 1)
        let avaialbelWidth = collectionView.frame.width - paddingSize
        let widthPerItem = avaialbelWidth / itemsPerRow
        var heightMultiplier:CGFloat = 1.7
        if UIDevice.current.model == "iPad" {
            heightMultiplier = 1.6
        }
        return CGSize(width: widthPerItem, height: heightMultiplier * widthPerItem)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        if productsList.count % 24 == 0, !searchBool {
            height = 20
            width = collectionView.frame.width
            searchBool = true
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let customCell: ProductCell? = cell as? ProductCell
        let product = productsList[indexPath.row]
        customCell?.productNameLabel.numberOfLines = 2
        customCell?.productNameLabel.text = product.name
        customCell?.productPrice.text = product.price?.priceDisplay
        /// To handle the case if prefetch is not called unfortunately
        /// This checks if it has to make an api call
        checkNextElementsAvailable("willDisplay",indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: productsList[indexPath.row].name, message: "Price of the Product is - ", preferredStyle: UIAlertController.Style.alert)
        if let productPrice = productsList[indexPath.row].price?.priceDisplay {
            alertController.message = (alertController.message ?? "Price: - ") + productPrice
        }
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController,animated: true)
    }
}
