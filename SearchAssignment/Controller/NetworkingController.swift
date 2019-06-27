//
//  NetworkingController.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 27/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import UIKit
import Alamofire

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
                self.showEmptyView()
                return
            }
            print(dataOptional)
            let jsonDecoder = JSONDecoder()
            do {
                let networkResponse = try? jsonDecoder.decode(NetworkResponse.self, from: data)
                /// handle in else block when no products are found
                guard let initialList = networkResponse?.data?.products, initialList.count != 0 else {
                    self.showEmptyView()
                    return
                }
                self.start = self.start + 1
                self.hideEmptyView()
                //self.collectionView.reloadData()
                self.addProductsToList(list: initialList)
                /// This helps to identify if a further api call to be made or not
//                if initialList.count == 24 {
//                    self.searchBool = true
//                }
                print(networkResponse ?? "Network Response is Nil")
            }
            print(data)
        }
    }
    
    /// Implement here if you want to do something while adding products
    private func addProductsToList(list: [Product]) {
        productsList.append(contentsOf: list)
        collectionView.reloadData()
    }
    
    func showEmptyView() {
        emptyView.isHidden = false
    }
    
    func hideEmptyView() {
        emptyView.isHidden = true
    }
    
    func checkNextElementsAvailable(_ methodName: String,indexPath: IndexPath) {
        if productsList.count < indexPath.row + 12, searchBool, productsList.count%24 == 0 {
            print("Before making api call coming from method - \(methodName)")
            makeSearchApiCall(searchText: searchedText, start: start)
        }
    }
}

