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
    
    private var productsList: [Product] = []
    private var productImages: [UIImage?] = []
    private var searchBool: Bool = true
    private var searchedText: String = ""
    private var start = 0
    
    
    //identifiers
    let reuseCellIdentifier = "CellIdentifier"
    let reuseHeaderIdentifier = "HeaderIdentifier"
    

    private var itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
    private var widthOfPhone: CGFloat = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        widthOfPhone = collectionView.frame.width
        
        //Create searchBar and assigning delegate
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        searchBar.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        //let nib = UINib(nibName: "ProductCell", bundle: Bundle.main)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: reuseCellIdentifier)
        //          (ProductCell.self, forCellWithReuseIdentifier:reuseCellIdentifier)
        //        collectionView.register(UINib(nibName: "ProductView", bundle: Bundle.main), forCellWithReuseIdentifier: reuseCellIdentifier)
        
        
        // Do any additional setup after loading the view.
    }
    
    //Implement here if you want to do something when adding products
    func addProductsToList(list: [Product]) {
        productsList.append(contentsOf: list)
        //productImages.append(contentsOf: [UIImage?](repeating: nil, count: list.count))
        collectionView.reloadData()
    }
    
    func productDownloadImage(indexPath: IndexPath, imageUrl: String) {
        //productImages.append(UIImage().pngData() ?? Data())
        //productImages.append(UIImage())
        if indexPath.row < productImages.count {
            Alamofire.request(imageUrl).response { (data) in
                if data.error != nil {
                    print("Some error caused to download image")
                    return
                }
                guard let dataImage = data.data else { return }
                //              if indexPath.row <= self.productImages.count {
                //                  self.productImages.append(UIImage())
                //              }
                DispatchQueue.main.async {
                    self.productImages[indexPath.row] = UIImage(data: dataImage)
                }
                print("Image downloaded for indexpath - \(indexPath)")
            }
        } else {
            productImages.append(contentsOf: [UIImage?](repeating: nil, count: indexPath.row - productImages.count + 1))
        }
    }
    
    
    func addNilImageIfNotPresent(indexPath: IndexPath) {
        if productImages.count <= indexPath.row {
            productImages.append(nil)
        }
    }
    
    func checkNextElementsAvailable(_ methodName: String,indexPath: IndexPath){
        if productsList.count < indexPath.row + 12, searchBool {
            //searchBool = false
            print("Before making api call coming from method - \(methodName)")
            makeSearchApiCall(searchText: searchedText, start: start)
        }
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
        //addNilImageIfNotPresent(indexPath: indexPath)
        //customCell?.productImage.image = productImages[indexPath.row] ?? UIImage()
        
        
        //customCell?.backgroundColor = UIColor.gray
        
        //checking for next elements and api call in will display
        checkNextElementsAvailable("willDisplay",indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: productsList[indexPath.row].name, message: "Price of the Product is - "+(productsList[indexPath.row].price?.priceDisplay ?? "ProductName"), preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController,animated: true)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

//Mark: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCellIdentifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        //adding the image to the array if no image is available
        //if the row is larger than the available images
        //addNilImageIfNotPresent(indexPath: indexPath)
        
        
        //cell.translatesAutoresizingMaskIntoConstraints = false
        cell.productImage.translatesAutoresizingMaskIntoConstraints = false
        cell.productPrice.translatesAutoresizingMaskIntoConstraints = false
        cell.productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cell.productImage.contentMode = .scaleAspectFit
        (cell.productImage).leadingAnchor.constraint(equalTo: cell.leadingAnchor , constant: 10).isActive = true
        (cell.productImage).trailingAnchor.constraint(equalTo: cell.trailingAnchor , constant: -10).isActive = true
        (cell.productImage).topAnchor.constraint(equalTo: cell.topAnchor , constant: 10).isActive = true
        //cell.productImage.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: .vertical)
        //cell.productImage.setContentHuggingPriority(UILayoutPriority(rawValue: 200), for: .vertical)
        
        //(cell.productImage).bottomAnchor.constraint(equalTo: cell.productNameLabel.topAnchor , constant: -10).isActive = true
        
        
        (cell.productPrice).leadingAnchor.constraint(equalTo: cell.leadingAnchor , constant: 10).isActive = true
        (cell.productPrice).trailingAnchor.constraint(equalTo: cell.trailingAnchor , constant: -10).isActive = true
        (cell.productPrice).bottomAnchor.constraint(equalTo: cell.bottomAnchor , constant: -10).isActive = true
        (cell.productPrice).topAnchor.constraint(equalTo: cell.productNameLabel.bottomAnchor , constant: 0).isActive = true
        
        
        (cell.productNameLabel).leadingAnchor.constraint(equalTo: cell.leadingAnchor , constant: 10).isActive = true
        (cell.productNameLabel).trailingAnchor.constraint(equalTo: cell.trailingAnchor , constant: -10).isActive = true
        (cell.productNameLabel).bottomAnchor.constraint(equalTo: cell.productPrice.topAnchor , constant: 0).isActive = true
        (cell.productNameLabel).topAnchor.constraint(equalTo: cell.productImage.bottomAnchor , constant: 20).isActive = true
        //
        
        // using kingfisher library for imageLoading
        let url  = URL(string: productsList[indexPath.row].images?[0] ?? "")
        cell.productImage.kf.setImage(with: url)
        
        cell.backgroundColor = UIColor.gray
        
        
        //
        //
        //        cell.setNeedsLayout()
        //        cell.layoutIfNeeded()
        
        //        if productImages.count > indexPath.row, productImages[indexPath.row] == nil {
        //            //TODO handle if the url of the image is invalid
        //            guard let imageUrl = productsList[indexPath.row].images?[0] else {return UICollectionViewCell()}
        //            productDownloadImage(indexPath: indexPath, imageUrl: imageUrl)
        //        }
        return cell
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
    //https://www.blibli.com/backend/search/products?searchTerm=iPhone&start=0&itemPerPage=24
    func makeSearchApiCall(searchText: String, start: Int) {
        searchBool = false
        let parameters: [String:String] = ["searchTerm": searchText, "start": "\(start)", "itemPerPage": "24"]
        let request = Alamofire.request("https://www.blibli.com/backend/search/products", method: .get, parameters: parameters)
        print(request)
        request.responseData { (dataOptional) in
            guard let data = dataOptional.data else { return }
            print(dataOptional)
            if dataOptional.error != nil {
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let networkResponse = try? jsonDecoder.decode(NetworkResponse.self, from: data)
                //handle in else when no products are found
                guard let initialList = networkResponse?.data?.products, initialList.count != 0 else { return }
                self.start = self.start + 1
                if initialList.count == 24 {
                    self.searchBool = true
                }
                self.addProductsToList(list: initialList)
                
                //print(networkResponse)
                //print(data)
            }
            print(data)
        }
    }
}

//Mark: - Search bar delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("inside searchBarTextDidBeginEditing")
        searchBar.becomeFirstResponder()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("inside searchBarTextDidEndEditing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("inside searchBarCancelButtonClicked")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("inside searchBarSearchButtonClicked")
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, !text.elementsEqual("") else { return }
        
        searchedText = text
        //clearing the old search results
        productsList.removeAll()
        productImages.removeAll()
        collectionView.reloadData()
        start = 0
        
        makeSearchApiCall(searchText: text, start: 0)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("inside textDidChange")
    }
    
}



