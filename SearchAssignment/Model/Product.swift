//
//  Product.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 26/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

class Product: Codable {
    let id: String?
    let name: String?
    let brand: String?
    let price: Price?
    let images: [String]?
    let url: String?
    
    private enum ProductCodingKeys: String, CodingKey {
        case id, name, images, url, brand, price
    }
}
