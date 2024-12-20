//
//  Models.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 3/12/24.
//

import Foundation


//MARK: - Using (enum CodingKeys: String, CodingKey) for suport file json from service


struct ReservationListModel: Codable{
    var response : ResponseModel
    var results : [ReservationModel]
}



struct ResponseReservationModel: Codable {
    var response: ResponseModel
    var results: ReservationModel
}

// MARK: - Reservation Model
struct ReservationModel: Codable {
    var reservationId: Int
    var guest: Int
    var room: Int
    var checkInDate: String
    var checkOutDate: String
    var totalAmount: Double
    var status: String

    enum CodingKeys: String, CodingKey {
        case reservationId = "reservation_id"
        case guest
        case room
        case checkInDate = "check_in_date"
        case checkOutDate = "check_out_date"
        case totalAmount = "total_amount"
        case status
    }
}

//// MARK: - Employee Model
//struct Employee: Codable {
//    var employeeId: Int
//    var firstName: String
//    var lastName: String
//    var position: String
//    var salary: Decimal
//
//    enum CodingKeys: String, CodingKey {
//        case employeeId = "employee_id"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case position
//        case salary
//    }
//}
//
//// MARK: - Service Model
//struct Service: Codable {
//    var serviceId: Int
//    var serviceName: String
//    var serviceDescription: String
//    var price: Decimal
//
//    
//    enum CodingKeys: String, CodingKey {
//        case serviceId = "service_id"
//        case serviceName = "service_name"
//        case serviceDescription = "service_description"
//        case price
//    }
//}
//
//// MARK: - Payment Model
//struct Payment: Codable {
//    var paymentId: Int
//    var reservation: Reservation
//    var paymentDate: Date
//    var amount: Decimal
//    var paymentMethod: String
//
//    enum CodingKeys: String, CodingKey {
//        case paymentId = "payment_id"
//        case reservation
//        case paymentDate = "payment_date"
//        case amount
//        case paymentMethod = "payment_method"
//    }
//}
//
//// MARK: - Feedback Model
//struct Feedback: Codable {
//    var feedbackId: Int
//    var guest: Guest
//    var reservation: Reservation
//    var feedbackDate: Date
//    var rating: Int
//    var comments: String
//
//    enum CodingKeys: String, CodingKey {
//        case feedbackId = "feedback_id"
//        case guest
//        case reservation
//        case feedbackDate = "feedback_date"
//        case rating
//        case comments
//    }
//}
//
//// MARK: - ReservationService Model
//struct ReservationService: Codable {
//    var reservationServiceId: Int
//    var reservation: Reservation
//    var service: Service
//    var quantity: Int
//    var totalPrice: Decimal
//
//    enum CodingKeys: String, CodingKey {
//        case reservationServiceId = "reservation_service_id"
//        case reservation
//        case service
//        case quantity
//        case totalPrice = "total_price"
//    }
//}
//
//// MARK: - History Model
//struct History: Codable {
//    var id: Int
//    var actionType: String
//    var guestId: Guest?
//    var roomId: Room?
//    var reservation: Reservation?
//    var serviceId: Service?
//    var actionDate: Date
//    var details: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case actionType = "action_type"
//        case guestId = "guest_id"
//        case roomId = "room_id"
//        case reservation
//        case serviceId = "service_id"
//        case actionDate = "action_date"
//        case details
//    }
//}
