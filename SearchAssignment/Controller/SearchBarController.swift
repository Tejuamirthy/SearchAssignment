//
//  SearchBarController.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 27/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit
//Mark: - Search bar delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.elementsEqual("") else { return }
        searchedText = text
        searchBar.endEditing(true)
        /// clearing the old search results
        productsList.removeAll()
        collectionView.reloadData()
        start = 0
        /// Making api call with the the text entered
        makeSearchApiCall(searchText: text, start: 0)
    }
}
