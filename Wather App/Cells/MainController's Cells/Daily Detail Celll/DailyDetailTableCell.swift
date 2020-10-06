//
//  DailyDetailTableCell.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import UIKit

class DailyDetailTableCell: UITableViewCell {
    //MARK: - Properties
    
    var cellData: WeatherModel? {
        didSet {
            if let data = cellData {
                let list = data.list
                let wind = list[0].wind.speed
                let visibility = Double((list[0].visibility) / 1000)
                let humidity = Int(list[0].main.humidity)
                
                windLbl.text = "\(wind) mh/s"
                visibilityLbl.text = "\(visibility) km"
                humidityLbl.text = "%\(humidity)"
                
            }
        }
    }
    
    
    
    lazy var headerLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "Günlük Detay"
        lbl.textColor = .slate
        lbl.font = UIFont(name: "Roboto-Medium", size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    var upView: UIView = {
       let u = UIView()
        u.translatesAutoresizingMaskIntoConstraints = false
        return u
    }()
    
    var downView: UIView = {
       let u = UIView()
        u.translatesAutoresizingMaskIntoConstraints = false
        return u
    }()
    
    var windContainer: UIView = {
        let u = UIView()
         u.translatesAutoresizingMaskIntoConstraints = false
         return u
    }()
    
    var visibilityContainer: UIView = {
        let u = UIView()
         u.translatesAutoresizingMaskIntoConstraints = false
         return u
    }()
    
    var humidityContainer: UIView = {
        let u = UIView()
         u.translatesAutoresizingMaskIntoConstraints = false
         return u
    }()
    
    var uvContainer: UIView = {
        let u = UIView()
         u.translatesAutoresizingMaskIntoConstraints = false
         return u
    }()
    
    lazy var windTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "Rüzgar"
        lbl.textColor = .slate
        lbl.font = UIFont(name: "Roboto-Medium", size: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    
    lazy var windLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "16 mh/s"
        lbl.textColor = .slate

        lbl.font = UIFont(name: "Roboto-Medium", size: 11)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var windIconImage: UIImageView = {
        let w = UIImageView()
        w.backgroundColor = .clear
        w.image = UIImage(named: "wind")
        w.contentMode = .scaleAspectFit
        w.clipsToBounds = true
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    lazy var visibilityTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "Görünürlük"
        lbl.textColor = .slate

        lbl.font = UIFont(name: "Roboto-Medium", size: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var visibilityLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "32 km"
        lbl.textColor = .slate

        lbl.font = UIFont(name: "Roboto-Medium", size: 11)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var visibilityIconImage: UIImageView = {
        let w = UIImageView()
        w.backgroundColor = .clear
        w.image = UIImage(named: "visibility")
        w.contentMode = .scaleAspectFit
        w.clipsToBounds = true
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    lazy var humidityTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "Nem"
        lbl.textColor = .slate

        lbl.font = UIFont(name: "Roboto-Medium", size: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var humidityLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "%64"
        lbl.textColor = .slate

        lbl.font = UIFont(name: "Roboto-Medium", size: 11)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var humidityIconImage: UIImageView = {
        let w = UIImageView()
        w.backgroundColor = .clear
        w.image = UIImage(named: "humidity")
        w.contentMode = .scaleAspectFit
        w.clipsToBounds = true
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
    lazy var uvTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "UV"
        lbl.textColor = .slate

        lbl.font = UIFont(name: "Roboto-Medium", size: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var uvLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "1.2"
        lbl.textColor = .slate

        lbl.font = UIFont(name: "Roboto-Medium", size: 11)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var uvIconImage: UIImageView = {
        let w = UIImageView()
        w.backgroundColor = .clear
        w.image = UIImage(named: "uv")
        w.contentMode = .scaleAspectFit
        w.clipsToBounds = true
        w.translatesAutoresizingMaskIntoConstraints = false
        return w
    }()
    
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
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .tableViewBackgroundColor
        backgroundColor = .tableViewBackgroundColor
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - setting up Constraint fo views and subviews
    fileprivate func setupConstraint() {
        contentView.addSubview(headerLbl)
        contentView.addSubview(mainView)
        mainView.addSubview(upView)
        mainView.addSubview(downView)
        mainView.addSubview(windIconImage)
        mainView.addSubview(windContainer)
        windContainer.addSubview(windTitleLbl)
        windContainer.addSubview(windLbl)
        
        mainView.addSubview(visibilityIconImage)
        mainView.addSubview(visibilityContainer)
        visibilityContainer.addSubview(visibilityTitleLbl)
        visibilityContainer.addSubview(visibilityLbl)
        
        mainView.addSubview(humidityIconImage)
        mainView.addSubview(humidityContainer)
        humidityContainer.addSubview(humidityTitleLbl)
        humidityContainer.addSubview(humidityLbl)
        mainView.addSubview(uvIconImage)
        mainView.addSubview(uvContainer)
        uvContainer.addSubview(uvTitleLbl)
        uvContainer.addSubview(uvLbl)
        
        NSLayoutConstraint.activate([
            
            headerLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: edgeSpacing),
            headerLbl.heightAnchor.constraint(equalToConstant: headerHeight),
            headerLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            headerLbl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: edgeSpacing),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -edgeSpacing),
            mainView.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 10),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            upView.topAnchor.constraint(equalTo: mainView.topAnchor),
            upView.bottomAnchor.constraint(equalTo: mainView.centerYAnchor),
            upView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            upView.widthAnchor.constraint(equalToConstant: 1),
            
            downView.topAnchor.constraint(equalTo: mainView.centerYAnchor),
            downView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            downView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            downView.widthAnchor.constraint(equalToConstant: 1),
            
            windIconImage.centerYAnchor.constraint(equalTo: upView.centerYAnchor),
            windIconImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16),
            windIconImage.heightAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.3),
            windIconImage.widthAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.3),
            
            windContainer.centerYAnchor.constraint(equalTo: upView.centerYAnchor),
            windContainer.leftAnchor.constraint(equalTo: windIconImage.rightAnchor, constant: 5),
            windContainer.heightAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.62),
            windContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.28),
            
            windTitleLbl.leftAnchor.constraint(equalTo: windContainer.leftAnchor, constant: 4),
            windTitleLbl.bottomAnchor.constraint(equalTo: windContainer.centerYAnchor),
            windTitleLbl.widthAnchor.constraint(equalTo: windContainer.widthAnchor, multiplier: 0.8),
            windTitleLbl.heightAnchor.constraint(equalTo: windContainer.heightAnchor, multiplier: 0.4),
            
            windLbl.leftAnchor.constraint(equalTo: windContainer.leftAnchor, constant: 4),
            windLbl.topAnchor.constraint(equalTo: windContainer.centerYAnchor),
            windLbl.widthAnchor.constraint(equalTo: windContainer.widthAnchor, multiplier: 0.8),
            windLbl.heightAnchor.constraint(equalTo: windContainer.heightAnchor, multiplier: 0.4),
            
            visibilityIconImage.centerYAnchor.constraint(equalTo: upView.centerYAnchor),
            visibilityIconImage.leftAnchor.constraint(equalTo: upView.rightAnchor, constant: 16),
            visibilityIconImage.heightAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.3),
            visibilityIconImage.widthAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.3),

            visibilityContainer.centerYAnchor.constraint(equalTo: upView.centerYAnchor),
            visibilityContainer.leftAnchor.constraint(equalTo: visibilityIconImage.rightAnchor, constant: 5),
            visibilityContainer.heightAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.62),
            visibilityContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.28),
            
            visibilityTitleLbl.leftAnchor.constraint(equalTo: visibilityContainer.leftAnchor, constant: 4),
            visibilityTitleLbl.bottomAnchor.constraint(equalTo: visibilityContainer.centerYAnchor),
            visibilityTitleLbl.widthAnchor.constraint(equalTo: visibilityContainer.widthAnchor, multiplier: 0.8),
            visibilityTitleLbl.heightAnchor.constraint(equalTo: visibilityContainer.heightAnchor, multiplier: 0.4),
            
            visibilityLbl.leftAnchor.constraint(equalTo: visibilityContainer.leftAnchor, constant: 4),
            visibilityLbl.topAnchor.constraint(equalTo: visibilityContainer.centerYAnchor),
            visibilityLbl.widthAnchor.constraint(equalTo: visibilityContainer.widthAnchor, multiplier: 0.8),
            visibilityLbl.heightAnchor.constraint(equalTo: visibilityContainer.heightAnchor, multiplier: 0.4),
            
            humidityIconImage.centerYAnchor.constraint(equalTo: downView.centerYAnchor),
            humidityIconImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 16),
            humidityIconImage.heightAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.3),
            humidityIconImage.widthAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.3),
            
            
            humidityContainer.centerYAnchor.constraint(equalTo: downView.centerYAnchor),
            humidityContainer.leftAnchor.constraint(equalTo: humidityIconImage.rightAnchor, constant: 5),
            humidityContainer.heightAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.62),
            humidityContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.28),
            
            humidityTitleLbl.leftAnchor.constraint(equalTo: humidityContainer.leftAnchor, constant: 4),
            humidityTitleLbl.bottomAnchor.constraint(equalTo: humidityContainer.centerYAnchor),
            humidityTitleLbl.widthAnchor.constraint(equalTo: humidityContainer.widthAnchor, multiplier: 0.8),
            humidityTitleLbl.heightAnchor.constraint(equalTo: humidityContainer.heightAnchor, multiplier: 0.4),
            
            humidityLbl.leftAnchor.constraint(equalTo: humidityContainer.leftAnchor, constant: 4),
            humidityLbl.topAnchor.constraint(equalTo: humidityContainer.centerYAnchor),
            humidityLbl.widthAnchor.constraint(equalTo: humidityContainer.widthAnchor, multiplier: 0.8),
            humidityLbl.heightAnchor.constraint(equalTo: humidityContainer.heightAnchor, multiplier: 0.4),
            
            uvIconImage.centerYAnchor.constraint(equalTo: downView.centerYAnchor),
            uvIconImage.leftAnchor.constraint(equalTo: downView.leftAnchor, constant: 16),
            uvIconImage.heightAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.3),
            uvIconImage.widthAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.3),
            
            uvContainer.centerYAnchor.constraint(equalTo: downView.centerYAnchor),
            uvContainer.leftAnchor.constraint(equalTo: uvIconImage.rightAnchor, constant: 5),
            uvContainer.heightAnchor.constraint(equalTo: upView.heightAnchor, multiplier: 0.62),
            uvContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.28),
            
            uvTitleLbl.leftAnchor.constraint(equalTo: uvContainer.leftAnchor, constant: 4),
            uvTitleLbl.bottomAnchor.constraint(equalTo: uvContainer.centerYAnchor),
            uvTitleLbl.widthAnchor.constraint(equalTo: uvContainer.widthAnchor, multiplier: 0.8),
            uvTitleLbl.heightAnchor.constraint(equalTo: uvContainer.heightAnchor, multiplier: 0.4),
            
            uvLbl.leftAnchor.constraint(equalTo: uvContainer.leftAnchor, constant: 4),
            uvLbl.topAnchor.constraint(equalTo: uvContainer.centerYAnchor),
            uvLbl.widthAnchor.constraint(equalTo: uvContainer.widthAnchor, multiplier: 0.8),
            uvLbl.heightAnchor.constraint(equalTo: uvContainer.heightAnchor, multiplier: 0.4),
            
            
        ])
    }
    
    
}
