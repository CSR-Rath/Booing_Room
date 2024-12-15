//
//  ReservationViewModel.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 4/12/24.
//

import UIKit

class ReservationViewModel {
   
    static let shared = ReservationViewModel()
    private let endPoint =  Endpoints.reservations
    
    func getReservationList(success: @escaping (_ response: ReservationListModel) -> Void){
        
        ApiManager.shared.apiConnection(url: endPoint)
        { (res: ReservationListModel) in
            success(res)
        }
    }
    
    func reservationDetail(id: Int, method: HTTPMethod, success: @escaping (_ response: ResponseReservationModel) -> Void){
        ApiManager.shared.apiConnection(url: endPoint+"/\(id)", method: method)
        {(res : ResponseReservationModel) in
            success(res)
        }
    }
    
    // MARK: - Post - Put (Geusts)
    func post_put_Reservation(param: Encodable, method: HTTPMethod, id: Int = 0, success: @escaping (_ response: ResponseReservationModel) -> Void){

        ApiManager.shared.apiConnection(url: endPoint, method: method, modelCodable: param)
        { (res: ResponseReservationModel) in
            
            success(res)
        }
    }
}



