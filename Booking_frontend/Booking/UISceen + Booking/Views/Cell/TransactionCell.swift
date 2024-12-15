//
//  TransactionCell.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 11/12/24.
//

import UIKit




class TransactionCell: UITableViewCell{
    
    var didTappedButton: (()->())?
    
    var didTappedDelete: (()->())?
    var didTappedEdit: (()->())?
    
    let lblPrice = UILabel()
    let lblName =  UILabel()
    let lblDate =  UILabel()
    let imgLogo = UIImageView()

    
    var decrementAndIncrement: Int = 1 {
        didSet{
            
        }
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TransactionCell{
    
    @objc  func decrementValue(_ sender: UIButton){
        
        if decrementAndIncrement > 1{
            decrementAndIncrement -= 1
            didTappedButton?()
        }
    }
    
    @objc func incrementValue(_ sender: UIButton){
        
        decrementAndIncrement += 1
        didTappedButton?()
    }
    
    

    private func setupUI(){
        
      
        addSubview(imgLogo)
        addSubview(lblPrice)
        addSubview(lblName)
        addSubview(lblDate)
        
        imgLogo.translatesAutoresizingMaskIntoConstraints = false
        lblPrice.translatesAutoresizingMaskIntoConstraints = false
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblDate.translatesAutoresizingMaskIntoConstraints = false

        
        imgLogo.backgroundColor = .lightGray
        imgLogo.layer.cornerRadius = 80/2
        imgLogo.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([

            
            lblPrice.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            lblPrice.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
            
            lblName.topAnchor.constraint(equalTo: lblPrice.bottomAnchor,constant: 10),
            lblName.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
            
            lblDate.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            lblDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
        ])
        
    }
}
