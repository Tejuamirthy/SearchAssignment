//
//  NetworkResponseModel.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 21/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

import Foundation

class NetworkResponse: Codable {
    var code: Int?
    var status: String?
    var data: DataInsideResponse?
    
    private enum ResponseCodingKey: String, CodingKey {
        case code
        case status
        case data
    }
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: ResponseCodingKey.self)
//        code = try values.decode(Int.self, forKey: .code)
//        status = try values.decode(String.self, forKey: .status)
//        data = try values.decode(DataInsideResponse.self, forKey: .data)
//    }
}

struct DataInsideResponse: Codable {
    //var pageType: [Any]?
    let searchTerm: String?
    //var suggestions: [Any]?
    //var correctedSearchResponses: [Any]?
    //let ageRestricted: Bool
    let products: [Product]?
    //var sorting: Any?
    //var filters: [Any]?
    //var paging: Any?
    //var maxOffers: Int
    //let serverCurrentTime: Double
    //var productInfo: Any?
    //let redirectionUrl: String
    //let itemCount: Int
    //var intentAttributes: Any?
    //var personalizedAttributes: Any?
    //var intentApplied: Bool
    //let showAllCategories: Bool
    //let searchPageUrl: String

    private enum CodingKeys: String, CodingKey {
        case searchTerm, products //, showAllCategories, searchPageUrl
    }
}

struct Product: Codable {
    let id: String?
    let name: String?
    //let brand: String
    let price: PriceStruct?
    let images: [String]?
    //let rootCategory: CategoryStruct
    let url: String?
//    var review: Review
//    
    private enum ProductCodingKeys: String, CodingKey {
        case id, name, price, images, url//, brand, price, images, rootCategory, url, review
    }
}

class PriceStruct: Codable {
    let priceDisplay: String?
    let strikeThroughPriceDisplay: String?
//    let discount: Int
//    let minPrice: Int
    
    private enum PriceCodingKeys: String, CodingKey {
        case priceDisplay
        case strikeThroughPriceDisplay
//        case discount
//        case minPrice
    }
    

}

class CategoryStruct: Codable {
    let id: String?
    let name: String?
    
    private enum CategoryCodingKeys: String, CodingKey {
        case id
        case name
    }
}

class Review: Codable {
    let rating: Int?
    let count: Int?
    
    private enum CodingKeys: String, CodingKey {
        case rating
        case count
    }
}
