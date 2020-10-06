//
//  HourlyWeatherCollectionCell.swift
//  weather
//
//  Created by Ali Aghajani on 10/1/20.
//

import Foundation
import UIKit

class HourlyWeatherCollectionCell:UICollectionViewCell {
    //MARK: - Properties
    
    var mainView: UIView = {
        let m = UIView()
        m.backgroundColor = .clear
        m.clipsToBounds = true
        m.translatesAutoresizingMaskIntoConstraints = false
        return m
    }()
    
    var iconView: UIView = {
        let m = UIView()
        m.backgroundColor = .white
        m.layer.shadowColor   = UIColor.gray.cgColor
        m.layer.shadowOffset  = CGSize(width: 2, height: 4)
        m.layer.shadowRadius  = 3
        m.layer.shadowOpacity = 0.2
        m.layer.cornerRadius = 8
        m.clipsToBounds = true
        m.translatesAutoresizingMaskIntoConstraints = false
        return m
    }()
    
    var weatherIconImage: UIImageView = {
        let w = UIImageView()
        w.backgroundColor = .clear
        w.image = UIImage(named: "sun")
        w.contentMode = .scaleAspectFit
        w.clipsToBounds = true
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    
    var timeLbl: UILabel = {
        let w = UILabel()
        w.text = "03:00"
        w.textColor = .slate

        w.textAlignment = .center
        w.font = UIFont(name: "Roboto-Medium", size: 12)
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tableViewBackgroundColor
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - seting up constraint for UI Elements
    fileprivate func setupConstraint() {
        contentView.addSubview(mainView)
        mainView.addSubview(iconView)
        iconView.addSubview(weatherIconImage)
        mainView.addSubview(timeLbl)
//        
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            mainView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            iconView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 4),
            iconView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.96),
            iconView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.96),
            iconView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),



            weatherIconImage.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            weatherIconImage.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            weatherIconImage.heightAnchor.constraint(equalTo: iconView.heightAnchor, multiplier: 0.68),
            weatherIconImage.widthAnchor.constraint(equalTo: iconView.heightAnchor, multiplier: 0.68),

            timeLbl.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            timeLbl.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            timeLbl.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.8),
            timeLbl.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.14)


        ])
    }
    
    
    
}
