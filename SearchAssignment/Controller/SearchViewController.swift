//
//  SearchViewController.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 21/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    var productsList: [Product] = []
    var searchBool: Bool = true
    var searchedText: String = ""
    var start = 0
    var makingApiCall = false
    var footer: UICollectionReusableView? = nil
    
    /// Reuse identifiers
    let reuseCellIdentifier = "CellIdentifier"
    let reuseHeaderIdentifier = "HeaderIdentifier"
    let reuseFooterString = "FooterIdentifier"
    /// Collection View layout constants
    var itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    /// Collection View outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// adding empty subview
        if let viewReference = self.view {
            viewReference.addSubview(emptyView)
            emptyView.translatesAutoresizingMaskIntoConstraints = false
            emptyView.topAnchor.constraint(equalTo: viewReference.topAnchor).isActive = true
            emptyView.leadingAnchor.constraint(equalTo: viewReference.leadingAnchor).isActive = true
            emptyView.trailingAnchor.constraint(equalTo: viewReference.trailingAnchor).isActive = true
            emptyView.bottomAnchor.constraint(equalTo: viewReference.bottomAnchor).isActive = true
            emptyView.isHidden = true
        }
        /// Create a searchBar, positioning in the navigation bar and assigning delegate
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        /// Assigning delegatees to the Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        /// Register to Collection View
        /// for using the xib with Fileowner set to the ProductCell class
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: reuseCellIdentifier)
        /// OR
        /// uncomment the last line to register with a UNib object
        /// Here ProductCell class is set to the View in xib and not to Fileowner
        /// collectionView.register(UINib(nibName: "ProductCell", bundle: Bundle.main), forCellWithReuseIdentifier:reuseCellIdentifier)
        collectionView.register(CustomReusableFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseFooterString)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
