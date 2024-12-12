//
//  TransactionDetailController.swift
//  Booking
//
//  Created by Rath! on 12/12/24.
//

import UIKit

struct DetailModel: Codable{
    let room : RoomModel
    let reservation : ReservationModel
    let geust : GeustModel
}

class TransactionDetailController: UIViewController {
    
    var detailModel : DetailModel? {
        didSet{
            let room = detailModel?.room
            let geust = detailModel?.geust
            let reservation = detailModel?.reservation
            
            lblValueList[0].text =  room?.roomName
            lblValueList[1].text =  room?.roomType
            lblValueList[2].text =  room?.pricePerNight.twoDigit(sign: "$")
            
            lblValueList[3].text = (geust?.lastName ?? "") + (geust?.firstName ?? "")
            
            lblValueList[4].text =  reservation?.checkInDate
            lblValueList[5].text =  reservation?.checkOutDate
            lblValueList[6].text = reservation?.totalAmount.twoDigit(sign: "$")
            
        }
    }
    
    var reservation : ReservationModel?
    


  
    var lblTitleList : [UILabel] = []
    var lblValueList : [UILabel] = []
    
    let dataList : [String] = ["Roon Name:", 
                               "Room Type:",
                               "Price per night:",
                               "Geust Name:",
                               "Check-in:",
                               "Check-out:",
                               "Total Amount"]

    let stackLeft = UIStackView()
    let stackRight = UIStackView()
    let stackContainer = UIStackView()
    
    override func loadView() {
        super.loadView()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        leftBarButton()
        title = "Transaction Detail"
        stackLeft.axis = .vertical
        stackLeft.spacing = 10
        stackLeft.distribution = .fill
        stackLeft.alignment = .fill
        stackLeft.translatesAutoresizingMaskIntoConstraints = false
        
        stackRight.axis = .vertical
        stackRight.spacing = 10
        stackRight.distribution = .fill
        stackRight.alignment = .fill
        stackRight.translatesAutoresizingMaskIntoConstraints = false
        
        
        for (index, item) in dataList.enumerated(){
            let lblTitle = UILabel()
            let lblValue = UILabel()
            
            lblTitle.text = item
            lblTitle.fontMedium(16)
            lblTitle.textColor = .darkGray
            
            lblValue.text = "_"
            lblValue.fontMedium(14)
            lblValue.textColor = .black
            
            lblTitleList.append(lblTitle)
            lblValueList.append(lblValue)
            
            stackLeft.addArrangedSubview(lblTitleList[index])
            stackRight.addArrangedSubview(lblValueList[index])
            
        }
        
        setupUI()
        getDataFromService()
    }
    
    
    func getDataFromService(){
        if let reservation = reservation{
            Loading.shared.showLoading()
            
            GuestsViewModel.shared.geustDetail(id: reservation.guest, method: .GET) { responseGeust in
                print("responseGeust", responseGeust)
                
                RoomViewModel.shared.roomDetail(id: reservation.room, method: .GET) { response in
                    print("response", response)
                    Loading.shared.hideLoading()
                    DispatchQueue.main.async { [self] in

                        let data = DetailModel(room: response.results,
                                               reservation: reservation,
                                               geust: responseGeust.results)
                        
                        detailModel = data
                        
                    }
                }
            }
            
        }
        
    }

    
    private func setupUI(){
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        stackContainer.addArrangedSubview(stackLeft)
        stackContainer.addArrangedSubview(stackRight)
        stackContainer.axis = .horizontal
        stackContainer.spacing = 0
        stackContainer.alignment = .fill
        stackContainer.distribution = .fillEqually
//        stackContainer.backgroundColor = .cyan
        view.addSubview(stackContainer)
        
        NSLayoutConstraint.activate([
            
            stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        ])
        
    }
    
}
