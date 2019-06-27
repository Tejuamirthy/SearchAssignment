//
//  Review.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 26/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

class Review: Codable {
    let rating: Int?
    let count: Int?
    
    private enum CodingKeys: String, CodingKey {
        case rating
        case count
    }
}
