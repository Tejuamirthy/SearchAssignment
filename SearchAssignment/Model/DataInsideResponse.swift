//
//  DataInsideResponse.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 27/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

class DataInsideResponse: Codable {
    let searchTerm: String?
    let products: [Product]?
    
    private enum CodingKeys: String, CodingKey {
        case searchTerm, products
    }
}
