//
//  CityQuickDetailTableCell.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import Foundation
import UIKit

class CityQuickDetailTableCell: UITableViewCell {
    //MARK: - Properties
    var weatherIconImage: UIImageView = {
        let w = UIImageView()
        w.backgroundColor = .clear
        w.image = UIImage(named: "sun")
        w.contentMode = .scaleAspectFit
        w.clipsToBounds = true
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var cityNameLbl: UILabel = {
        let w = UILabel()
        w.text = "Istanbul"
        w.textColor = .slate
        w.font = UIFont(name: "Roboto-Medium", size: 14)
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var dateLbl: UILabel = {
        let w = UILabel()
        w.textColor = .customPurple
        w.text = "7/27/2020"
        w.font = UIFont(name: "Roboto-Medium", size: 12)
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var weatherDegreeLbl: UILabel = {
        let w = UILabel()
        w.textColor = .customPurple
        w.font = UIFont(name: "Roboto-Medium", size: 28)
        w.text = "35 C"
        w.backgroundColor = .clear
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: edgeSpacing, left: edgeSpacing, bottom: 3, right: edgeSpacing))
    }
    
    fileprivate func setupUI() {
//        self.backgroundColor = .tableViewBackgroundColor
//        contentView.backgroundColor = .white
//        contentView.layer.masksToBounds = false
//        contentView.clipsToBounds = false
//        contentView.layer.shadowColor   = UIColor.gray.cgColor
//        contentView.layer.shadowOffset  = CGSize(width: 1, height: 2)
//        contentView.layer.shadowRadius  = 2
//        contentView.layer.shadowOpacity = 0.2
//        contentView.layer.cornerRadius  = 12
    }
    
    fileprivate func setupConstraint() {
        addSubview(weatherIconImage)
        addSubview(cityNameLbl)
        addSubview(dateLbl)
        addSubview(weatherDegreeLbl)
        
        NSLayoutConstraint.activate([
            weatherIconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: edgeSpacing * 2.5),
            weatherIconImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherIconImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.58),
            weatherIconImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.58),
            
            cityNameLbl.bottomAnchor.constraint(equalTo: centerYAnchor),
            cityNameLbl.topAnchor.constraint(equalTo: weatherIconImage.topAnchor),
            cityNameLbl.leftAnchor.constraint(equalTo: weatherIconImage.rightAnchor, constant: edgeSpacing * 1.2),
            cityNameLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.36),
            
            dateLbl.topAnchor.constraint(equalTo: centerYAnchor),
            dateLbl.bottomAnchor.constraint(equalTo: weatherIconImage.bottomAnchor),
            dateLbl.leftAnchor.constraint(equalTo: weatherIconImage.rightAnchor, constant: edgeSpacing * 1.2),
            dateLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.24),
            
            weatherDegreeLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -(edgeSpacing * 2.5)),
            weatherDegreeLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherDegreeLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.19),
            weatherDegreeLbl.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.64)
        ])
    }
    
}
