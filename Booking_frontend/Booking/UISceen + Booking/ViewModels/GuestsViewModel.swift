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
    
    func getGuestsList(success: @escaping (_ response: GeustListModel) -> Void){
        
        ApiManager.shared.apiConnection(url: endPoint)
        { (res: GeustListModel) in
            success(res)
        }
    }
    
    func geustDetail(id: Int, method: HTTPMethod, success: @escaping (_ response: GeustModel) -> Void){
        ApiManager.shared.apiConnection(url: endPoint+"/\(id)",
                                        method: method)
        {(res : GeustModel) in
            success(res)
        }
    }
    
    // MARK: - Post - Put (Geusts)
    func post_put_Guests(param: Encodable, method: HTTPMethod, id: Int = 0,
                    success: @escaping (_ response: ResponseGeustModel) -> Void){
        
        ApiManager.shared.apiConnection(url: endPoint,
                                        method: method,
                                        modelCodable: param)
        { (res: ResponseGeustModel) in
            
            success(res)
        }
    }
}
