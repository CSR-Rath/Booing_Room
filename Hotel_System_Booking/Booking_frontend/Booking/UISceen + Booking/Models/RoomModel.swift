//
//  RoomModel.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 11/12/24.
//

import Foundation

//MARK: - Using (enum CodingKeys: String, CodingKey) for suport file json from service

struct RoomListModel: Codable{
    var response : ResponseModel
    var results : [RoomModel]
}

struct RoomModel: Codable {
    var id: Int
    var roomName: String
    var roomType: String
    var isAvailable: String
    var pricePerNight: Double

    enum CodingKeys: String, CodingKey {
        case id
        case roomName = "room_name"
        case roomType = "room_type"
        case isAvailable = "is_available"
        case pricePerNight = "price_per_night"
    }
}
