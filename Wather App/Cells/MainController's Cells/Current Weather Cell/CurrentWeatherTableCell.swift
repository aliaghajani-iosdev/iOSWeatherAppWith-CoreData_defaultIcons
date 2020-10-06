//
//  CurrentWeatherTableCell.swift
//  weather
//
//  Created by Ali Aghajani on 10/1/20.
//

import Foundation
import UIKit

class CurrentWeatherTableCell: UITableViewCell {
    //MARK: - Properties
    
    var cellData: WeatherModel? {
        didSet {
            guard let Data = cellData else {return}
            let list: [List] = Data.list
            let main = list[0].main
            let weather = list[0].weather
            let iconName = weather[0].icon
            let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let date = formatter.date(from: list[0].dt_txt) else { return }
                formatter.dateFormat = "yyyy"
                let year = formatter.string(from: date)
                formatter.dateFormat = "MM"
                let month = formatter.string(from: date)
                formatter.dateFormat = "dd"
                let day = formatter.string(from: date)
            
            minWeatherDegreeLbl.text = "\(Int(main.temp_min))°C"
            maxWeatherDegreeLbl.text = "\(Int(main.temp_max))°C"
            weatherSituationLbl.text = weather[0].description
            weatherIconImage.image = UIImage(named: iconName) ?? UIImage(named: "")
            print("----------\(iconName)-----------")
            dateLbl.text = "\(month)/\(day)/\(year)"
            weatherDegreeLbl.text =  "\(Int(main.temp))°C"
            
        }
    }
    
    
    var mainView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.masksToBounds = false
        v.clipsToBounds = false
        v.layer.shadowColor   = UIColor.gray.cgColor
        v.layer.shadowOffset  = CGSize(width: 2, height: 4)
        v.layer.shadowRadius  = 6
        v.layer.shadowOpacity = 0.3
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var middleContainer: UIView = {
        let m = UIView()
        m.backgroundColor = .clear
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
    
    var weatherDegreeLbl: UILabel = {
        let w = UILabel()
        w.textColor = .customPurple
        w.font = UIFont(name: "Roboto-Medium", size: 36)
        w.text = "35 C"
        w.backgroundColor = .clear
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var weatherSituationLbl: UILabel = {
        let w = UILabel()
        w.adjustsFontSizeToFitWidth = true
        w.textColor = .slate
        w.text = "Açık, güneşli"
        w.font = UIFont(name: "Roboto-Medium", size: 14)
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var dateLbl: UILabel = {
        let w = UILabel()
        w.textColor = .customPurple
        w.text = "7/27/2020"
        w.font = UIFont(name: "Roboto-Medium", size: 13)
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var separatorView: UIView = {
        let s = UIView()
        s.backgroundColor = .gray
        s.alpha = 0.3
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    var maxDegreeIconImage: UIImageView = {
        let w = UIImageView()
        w.contentMode = .scaleAspectFit
        w.image = UIImage(named: "max")
        w.clipsToBounds = true
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var minDegreeIconImage: UIImageView = {
        let w = UIImageView()
        w.contentMode = .scaleAspectFit
        w.image = UIImage(named: "min")
        w.clipsToBounds = true
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var maxWeatherDegreeLbl: UILabel = {
        let w = UILabel()
        w.textColor = .slate
        w.font = UIFont(name: "Roboto-Regular", size: 16)
        w.text = "35"
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    var minWeatherDegreeLbl: UILabel = {
        let w = UILabel()
        w.text = "25"
        w.textColor = .slate
        w.font = UIFont(name: "Roboto-Regular", size: 16)
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    //MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraint()
        backgroundColor = .tableViewBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - seting up constraint of UI elements
    func setupConstraint() {
        contentView.addSubview(mainView)
        mainView.addSubview(weatherIconImage)
        mainView.addSubview(middleContainer)
        middleContainer.addSubview(weatherDegreeLbl)
        middleContainer.addSubview(weatherSituationLbl)
        middleContainer.addSubview(dateLbl)
        
        mainView.addSubview(separatorView)
        mainView.addSubview(maxDegreeIconImage)
        mainView.addSubview(minDegreeIconImage)
        mainView.addSubview(maxWeatherDegreeLbl)
        mainView.addSubview(minWeatherDegreeLbl)

        
        NSLayoutConstraint.activate([
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -edgeSpacing),
            mainView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: edgeSpacing),
            mainView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
        
            weatherIconImage.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            weatherIconImage.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.27),
            weatherIconImage.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.76),
            weatherIconImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 28),
            
            middleContainer.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5),
            middleContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.34),
            middleContainer.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            middleContainer.leftAnchor.constraint(equalTo: weatherIconImage.rightAnchor, constant: 10),
            
            weatherDegreeLbl.rightAnchor.constraint(equalTo: middleContainer.rightAnchor, constant: -4),
            weatherDegreeLbl.widthAnchor.constraint(equalTo: middleContainer.widthAnchor, multiplier: 0.8),
            weatherDegreeLbl.topAnchor.constraint(equalTo: middleContainer.topAnchor),
            weatherDegreeLbl.heightAnchor.constraint(equalTo: middleContainer.heightAnchor, multiplier: 0.58),
            
            weatherSituationLbl.topAnchor.constraint(equalTo: weatherDegreeLbl.bottomAnchor),
            weatherSituationLbl.leftAnchor.constraint(equalTo: weatherDegreeLbl.leftAnchor),
            weatherSituationLbl.rightAnchor.constraint(equalTo: weatherDegreeLbl.rightAnchor),
            weatherSituationLbl.heightAnchor.constraint(equalTo: middleContainer.heightAnchor, multiplier: 0.17),
            
            dateLbl.topAnchor.constraint(equalTo: weatherSituationLbl.bottomAnchor, constant: 4),
            dateLbl.leftAnchor.constraint(equalTo: weatherDegreeLbl.leftAnchor),
            dateLbl.rightAnchor.constraint(equalTo: weatherDegreeLbl.rightAnchor),
            dateLbl.heightAnchor.constraint(equalTo: middleContainer.heightAnchor, multiplier: 0.17),
            
            
            separatorView.leftAnchor.constraint(equalTo: middleContainer.rightAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 0.7),
            separatorView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.52),
            separatorView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            
            maxDegreeIconImage.bottomAnchor.constraint(equalTo: mainView.centerYAnchor , constant: -13),
            maxDegreeIconImage.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.03),
            maxDegreeIconImage.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.03),
            maxDegreeIconImage.leftAnchor.constraint(equalTo: separatorView.rightAnchor, constant: 18),
            
            minDegreeIconImage.topAnchor.constraint(equalTo: mainView.centerYAnchor , constant: 13),
            minDegreeIconImage.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.03),
            minDegreeIconImage.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.03),
            minDegreeIconImage.leftAnchor.constraint(equalTo: separatorView.rightAnchor, constant: 18),
            
            maxWeatherDegreeLbl.leftAnchor.constraint(equalTo: maxDegreeIconImage.rightAnchor, constant: 8),
            maxWeatherDegreeLbl.bottomAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -13),
            maxWeatherDegreeLbl.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier:  0.04),
            maxWeatherDegreeLbl.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6),
            
            minWeatherDegreeLbl.leftAnchor.constraint(equalTo: maxDegreeIconImage.rightAnchor, constant: 8),
            minWeatherDegreeLbl.bottomAnchor.constraint(equalTo: minDegreeIconImage.bottomAnchor),
            minWeatherDegreeLbl.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier:  0.04),
            minWeatherDegreeLbl.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6),
            
        ])
    }
    
    
    
    
    
    
}
