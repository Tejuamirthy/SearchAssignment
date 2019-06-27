//
//  SearchViewController.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 21/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SearchViewController: UIViewController {
    var productsList: [Product] = []
    private var searchBool: Bool = true
    private var searchedText: String = ""
    private var start = 0
    /// Reuse identifiers
    let reuseCellIdentifier = "CellIdentifier"
    let reuseHeaderIdentifier = "HeaderIdentifier"
    /// Collection View layout constants
    private var itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    /// Collection View outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    /// Implement here if you want to do something while adding products
    func addProductsToList(list: [Product]) {
        productsList.append(contentsOf: list)
        collectionView.reloadData()
    }

    func checkNextElementsAvailable(_ methodName: String,indexPath: IndexPath){
        if productsList.count < indexPath.row + 12, searchBool {
            print("Before making api call coming from method - \(methodName)")
            makeSearchApiCall(searchText: searchedText, start: start)
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

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
        let alertController = UIAlertController(title: productsList[indexPath.row].name, message: "Price of the Product is - "+(productsList[indexPath.row].price?.priceDisplay ?? "ProductName"), preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController,animated: true)
    }
}


//Mark: - UICollectionViewDataSourcePrefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //place the prefectching using api call logic here
        
        //implementing image download and save into data for all the indexpaths
        for indexPath in indexPaths {
            //            addNilImageIfNotPresent(indexPath: indexPath)
            //            if productImages[indexPath.row] == nil {
            //                guard let imageUrl = productsList[indexPath.row].images?[0] else {return}
            //                productDownloadImage(indexPath: indexPath ,imageUrl: imageUrl)
            //            }
            checkNextElementsAvailable("prefetchItemsAt",indexPath: indexPath)
        }
    }
}

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
    
    func adjustSize() {
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
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

// Mark: - Networking using alamoFire
extension SearchViewController {
    
    func makeSearchApiCall(searchText: String, start: Int) {
        searchBool = false
        let parameters: [String:String] = ["searchTerm": searchText, "start": "\(start)", "itemPerPage": "24"]
        let request = Alamofire.request("https://www.blibli.com/backend/search/products", method: .get, parameters: parameters)
        print(request)
        request.responseData { (dataOptional) in
            guard let data = dataOptional.data else { return }
            if dataOptional.error != nil {
                return
            }
            print(dataOptional)
            let jsonDecoder = JSONDecoder()
            do {
                let networkResponse = try? jsonDecoder.decode(NetworkResponse.self, from: data)
                /// handle in else block when no products are found
                guard let initialList = networkResponse?.data?.products, initialList.count != 0 else { return }
                self.start = self.start + 1
                /// This helps to identify if a further api call to be made or not
                if initialList.count == 24 {
                    self.searchBool = true
                }
                self.addProductsToList(list: initialList)
                print(networkResponse ?? "Network Response is Nil")
            }
            print(data)
        }
    }
}

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



