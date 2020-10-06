//
//  CityTableCell.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import Foundation
import UIKit

class CityTableCell: UITableViewCell {
    //MARK: - properties
    var listOfAddedCities = [String]()
    var handleAddingCityDelegate: AddCityDelegate?
    
    lazy var cityNameLbl: UILabel = {
        let w = UILabel()
        w.text = "Istanbul"
        w.textColor = .slate
        w.font = UIFont(name: "Roboto-Medium", size: 14)
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    lazy var addCityBtn: UIButton = {
        let add = UIButton()
        add.setTitle("Ekle", for: .normal)
        add.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 14)
        add.setTitleColor(.customPurple, for: .normal)
        add.backgroundColor = .clear
        add.addTarget(self, action: #selector(addCity), for: .touchUpInside)
        add.isUserInteractionEnabled = true
        add.translatesAutoresizingMaskIntoConstraints = false
        return add
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - handling action when user tapped on "Ekle"
    @objc func addCity() {
        if let cityName = cityNameLbl.text {
            if let delegate = handleAddingCityDelegate {
                delegate.handleAdding(cityName: cityName)
            }
        }
    }
    
    
    
    //MARK: - seting up constraint
    fileprivate func setupConstraint() {
        contentView.addSubview(cityNameLbl)
        contentView.addSubview(addCityBtn)
        
        NSLayoutConstraint.activate([
            cityNameLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityNameLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: edgeSpacing + 4),
            cityNameLbl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.38),
            cityNameLbl.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.72),
            
            addCityBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addCityBtn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -edgeSpacing),
            addCityBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12),
            addCityBtn.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.72),
            
        ])
    }
}
