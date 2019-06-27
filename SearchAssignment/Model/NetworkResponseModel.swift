//
//  NetworkResponseModel.swift
//  SearchAssignment
//
//  Created by Amirthy Tejeshwar on 21/06/19.
//  Copyright © 2019 coviam. All rights reserved.
//

class NetworkResponse: Codable {
    var code: Int?
    var status: String?
    var data: DataInsideResponse?
    
    private enum ResponseCodingKey: String, CodingKey {
        case code, status, data
    }
}
