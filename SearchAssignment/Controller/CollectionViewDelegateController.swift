//
//  CollectionViewDelegateController.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 27/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

//Mark: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    
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
            alertController.message = alertController.message ?? "Price: - " + productPrice
        }
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController,animated: true)
    }
}
