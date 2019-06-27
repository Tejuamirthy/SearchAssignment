//
//  PrefetchingController.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 27/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit
//Mark: - UICollectionViewDataSourcePrefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        /// the prefectching using api call logic here
        for indexPath in indexPaths {
            checkNextElementsAvailable("prefetchItemsAt",indexPath: indexPath)
        }
    }
}
