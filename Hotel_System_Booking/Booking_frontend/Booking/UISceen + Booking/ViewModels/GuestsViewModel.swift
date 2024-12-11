//
//  GuestsViewModel.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 3/12/24.
//

import UIKit

class GuestsViewModel{
    
    private let endPoint =  Endpoints.guests
    static let shared = GuestsViewModel()
    
    func getGuestsList(success: @escaping (_ response: GeustListResponse) -> Void){
        
        ApiManager.shared.apiConnection(url: endPoint)
        { (res: GeustListResponse) in
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
    func post_put_Guests(param: Encodable, method: HTTPMethod, id: Int = 0,
                    success: @escaping (_ response: GeustPostResponse) -> Void){
        
//        var endpoint = endPoint
        
//        if id != 0{
//            endpoint = endPoint+"/\(id)"
//        }
        
        ApiManager.shared.apiConnection(url: endPoint,
                                        method: method,
                                        modelCodable: param)
        { (res: GeustPostResponse) in
            
            success(res)
        }
    }
}
