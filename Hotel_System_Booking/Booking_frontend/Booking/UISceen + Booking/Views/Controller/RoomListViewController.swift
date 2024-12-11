//
//  RoomListViewController.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 4/12/24.
//

import UIKit

class RoomListViewController: UITableViewController {
    
    var isFromReservation: Bool = false
    var isFirstTime: Bool = false
    let btn1 = UIButton()
    let btn2 = UIButton()
    let btn3 = UIButton()
    
    var didSelectedCell: ((RoomModel)->())?
    
    // Sample data
    var rooms: [RoomModel] = []{
        didSet{
            tableView.reloadData()
            Loading.shared.hideLoading()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Room List"
        leftBarButton()
        tableView.sectionHeaderTopPadding = 0
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: "RoomCell")
        setDataFromService(status: .none)

    }
    
    func setDataFromService(status: StatuRoom){
        RoomViewModel.shared.getRoomList(query: status) { response in
            DispatchQueue.main.async {
                self.rooms = response.results
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if rooms.count > 0{
            tableView.restore()
        }else{
            tableView.setEmptyView()
        }
        
        return rooms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomTableViewCell
        let room = rooms[indexPath.row]
        
        if "available" == room.isAvailable{
            cell.backgroundColor =  .white
        }else{
            cell.backgroundColor = .red.withAlphaComponent(0.1)
        }
        
        cell.roomType.text = room.roomType
        cell.roomNameLabel.text = "Name: \(room.roomName) \t\t\t ID: \(room.id)"
        cell.roomAvailabilityLabel.text = "Price: \(room.pricePerNight.twoDigit(sign: "$"))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFromReservation == true {
            let selectedRoom = rooms[indexPath.row]
            if selectedRoom.isAvailable == "available"{
                didSelectedCell?(selectedRoom)
            }else{
                showAlert("The room is not available.")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Message!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
   
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        btn1.setTitle("All", for: .normal)
        btn1.tag = 0
       
        btn1.layer.cornerRadius = 5
        btn1.addTargetButton(target: self, action: #selector(didTappedQuery))
        
        
        btn2.setTitle("Avaiable", for: .normal)
        btn2.tag = 1
        btn2.layer.cornerRadius = 5
        btn2.addTargetButton(target: self, action: #selector(didTappedQuery))
        
       
        btn3.setTitle("Occupied", for: .normal)
        btn3.tag = 2
        btn3.layer.cornerRadius = 5
        btn3.addTargetButton(target: self, action: #selector(didTappedQuery))
        
        if !isFirstTime{
            btn1.backgroundColor = .mainBlueColor
            btn2.backgroundColor = .orange.withAlphaComponent(0.5)
            btn3.backgroundColor =  .orange.withAlphaComponent(0.5)
            
            btn1.titleLabel?.fontBold(14)
            btn2.titleLabel?.fontMedium(14)
            btn3.titleLabel?.fontMedium(14)
        }
        
        let stack = UIStackView(arrangedSubviews: [btn1,btn2,btn3])
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    @objc func didTappedQuery(_ sender: UIButton){
        
        let arrayButton = [btn1,btn2,btn3]
        isFirstTime = true
        
        arrayButton.forEach({ btn in
            
            if sender.tag == btn.tag{
                btn.backgroundColor =  .mainBlueColor
                btn.titleLabel?.fontBold(14)
            }else{
                btn.backgroundColor = .orange.withAlphaComponent(0.5)
                btn.titleLabel?.fontMedium(14)
            }
        })
        
        if sender.tag == 0{
            
            setDataFromService(status: .none)
            
        }else if sender.tag == 1{
            
            setDataFromService(status: .available)
            
        }else if sender.tag == 2{
            
            setDataFromService(status: .occupied)
        }
    }
}


