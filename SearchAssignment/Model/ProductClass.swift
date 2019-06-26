//
//  ProductClass.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 24/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import Foundation
import UIKit

class ProductClass: NSObject, UICollectionViewDataSource {
    
    var productsList: [SingleProduct] = []
    init(products: [Product]) {
        for product in products {
            productsList.append(SingleProduct(product: product))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

class SingleProduct {
    var product: Product?
    var image: UIImage?
    init(product: Product) {
        
    }
}
