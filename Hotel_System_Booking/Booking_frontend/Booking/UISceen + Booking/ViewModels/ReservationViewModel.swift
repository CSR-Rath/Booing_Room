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
    
    func deteleGeusts(id: Int, success: @escaping (_ response: ResponseModel) -> Void){
        ApiManager.shared.apiConnection(url: endPoint+"/\(id)",
                                        method: .DELETE)
        {(res : ResponseModel) in
            success(res)
        }
    }
    
    // MARK: - Post - Put (Geusts)
    func post_put_Reservation(param: Encodable, method: HTTPMethod, id: Int = 0, success: @escaping (_ response: ReservationPostModel) -> Void){
        
//        var endpoint = endPoint
        
//        if id != 0{
//            endpoint = endPoint+"/\(id)"
//        }
        
        ApiManager.shared.apiConnection(url: endPoint,
                                        method: method,
                                        //                                            param:  param
                                        modelCodable: param
        )
        { (res: ReservationPostModel) in
            
            success(res)
        }
    }
}


