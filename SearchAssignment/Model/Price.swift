//
//  Price.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 26/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

class Price: Codable {
    let priceDisplay: String?
    let strikeThroughPriceDisplay: String?
    let discount: Int?
    let minPrice: Int?
    
    private enum PriceCodingKeys: String, CodingKey {
        case priceDisplay
        case strikeThroughPriceDisplay
        case discount
        case minPrice
    }
}
