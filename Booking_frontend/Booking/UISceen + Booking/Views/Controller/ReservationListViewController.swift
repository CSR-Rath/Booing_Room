//
//  ReservationListViewController.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 4/12/24.
//

import UIKit

class ReservationListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    private var reservations: [ReservationModel] = []{
        didSet{
            tableView.reloadData()
            Loading.shared.hideLoading()
        }
    }
    private let tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        leftBarButton()
        setupUI()
        getDateFromservice()
    }
    
    func getDateFromservice(){
        ReservationViewModel.shared.getReservationList { response in
            print(response)
            DispatchQueue.main.async { [self] in
                if response.response.status <= 299 &&  response.response.status >= 200{
                    reservations = response.results.reversed()
                }else{
                    AlertMessage.shared.alertError(title: "Message",
                                                   message: response.response.message)
                }
            }
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = "Histories"
        view.backgroundColor = .white
        tableView.register(ReservationCell.self, forCellReuseIdentifier: "ReservationCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if reservations.count > 0{
            tableView.restore()
        }else{
            tableView.setEmptyView()
        }
        
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as! ReservationCell
        let reservation = reservations[indexPath.row]

        cell.configure(with: reservation)  // Configure the cell
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Loading.shared.showLoading()
        tableView.deselectRow(at: indexPath, animated: true)
        let data = reservations[indexPath.row]
        
        let vc = TransactionDetailController()
        vc.reservation = data
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
