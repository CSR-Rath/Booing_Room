//
//  RoomViewModel.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 5/12/24.
//

import UIKit

enum StatuRoom{
    case available
    case occupied
    case none
}

class RoomViewModel {

    static let shared = RoomViewModel()
    private let endPoint =  Endpoints.room
    
    func getRoomList(query: StatuRoom, success: @escaping (_ response: RoomListModel) -> Void){
       
        var endPointQuery: String = ""
        
        switch query{
        case .available:
            endPointQuery = "rooms?is_available=available"
        case .occupied:
            endPointQuery = "rooms?is_available=occupied"
        case .none:
            endPointQuery = endPoint
        }
        
         
        ApiManager.shared.apiConnection(url: endPointQuery)
        { (res: RoomListModel) in
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
    
    func roomDetail(id: Int, method: HTTPMethod, success: @escaping (_ response: ResponseRoomModel) -> Void){
        ApiManager.shared.apiConnection(url: endPoint+"/\(id)", method: method)
        {(res : ResponseRoomModel) in
            success(res)
        }
    }
    
    
    // MARK: - Post - Put (Geusts)
    func post_put_Room(param: Encodable, method: HTTPMethod, id: Int = 0, success: @escaping (_ response: ResponseGeustModel) -> Void){
        
        ApiManager.shared.apiConnection(url: endPoint,
                                        method: method,
                                        modelCodable: param)
        { (res: ResponseGeustModel) in
            
            success(res)
        }
    }
}
