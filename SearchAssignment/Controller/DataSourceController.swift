//
//  DataSourceController.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 27/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit
import Kingfisher

//Mark: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCellIdentifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor.gray
        // using kingfisher library for imageLoading
        let url  = URL(string: productsList[indexPath.row].images?[0] ?? "")
        cell.productImage.kf.setImage(with: url)
        cell.productImage.contentMode = .scaleAspectFit
        /// disabling the autoresizing to set custom constraints
        cell.productImage.translatesAutoresizingMaskIntoConstraints = false
        cell.productPrice.translatesAutoresizingMaskIntoConstraints = false
        cell.productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        /// setting constraints to productImage using anchors
        (cell.productImage).leadingAnchor.constraint(equalTo: cell.leadingAnchor , constant: 10).isActive = true
        (cell.productImage).trailingAnchor.constraint(equalTo: cell.trailingAnchor , constant: -10).isActive = true
        (cell.productImage).topAnchor.constraint(equalTo: cell.topAnchor , constant: 10).isActive = true
        /// uncomment below to use the Content Hugging & Compression property
        /// cell.productImage.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: .vertical)
        /// cell.productImage.setContentHuggingPriority(UILayoutPriority(rawValue: 200), for: .vertical)
        /// setting constraints to productPrice using anchors
        (cell.productPrice).leadingAnchor.constraint(equalTo: cell.leadingAnchor , constant: 10).isActive = true
        (cell.productPrice).trailingAnchor.constraint(equalTo: cell.trailingAnchor , constant: -10).isActive = true
        (cell.productPrice).bottomAnchor.constraint(equalTo: cell.bottomAnchor , constant: -10).isActive = true
        (cell.productPrice).topAnchor.constraint(equalTo: cell.productNameLabel.bottomAnchor , constant: 0).isActive = true
        /// setting constraints to productNameLabel using anchors
        (cell.productNameLabel).leadingAnchor.constraint(equalTo: cell.leadingAnchor , constant: 10).isActive = true
        (cell.productNameLabel).trailingAnchor.constraint(equalTo: cell.trailingAnchor , constant: -10).isActive = true
        (cell.productNameLabel).bottomAnchor.constraint(equalTo: cell.productPrice.topAnchor , constant: 0).isActive = true
        (cell.productNameLabel).topAnchor.constraint(equalTo: cell.productImage.bottomAnchor , constant: 20).isActive = true
        return cell
    }
}
