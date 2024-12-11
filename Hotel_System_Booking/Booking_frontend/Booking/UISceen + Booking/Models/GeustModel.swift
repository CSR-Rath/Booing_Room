//
//  GeustModel.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 11/12/24.
//

import Foundation

//MARK: - Using (enum CodingKeys: String, CodingKey) for suport file json from service

struct GeustListResponse: Codable {
    var response: ResponseModel
    var results: [GeustModel]
}

struct GeustPostResponse: Codable {
    var response: ResponseModel
    var results: GeustModel
}

struct GeustModel: Codable {
    var id: Int
    var firstName: String
    var email: String
    var lastName: String
    var address: String
    var phone: String

    // Use CodingKeys to match the JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case email
        case lastName = "last_name"
        case address
        case phone
    }
}
