//
//  Category.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 26/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

class Category: Codable {
    let id: String?
    let name: String?
    
    private enum CategoryCodingKeys: String, CodingKey {
        case id
        case name
    }
}
