//
//  HourlyWeatherTableCell.swift
//  weather
//
//  Created by Ali Aghajani on 10/1/20.
//

import Foundation
import UIKit

class HourlyWeatherTableCell: UITableViewCell {
    //MARK: - Properties
    var hourlyList: [HourlyWeather] = []
    var hourData: [HourlyWeather] = []
    var hourList: [String] = []
    var hhh: [String] = []
    var cellData: WeatherModel? {
        didSet {
            var index = 0
            guard let Data = cellData else {return}
            let list = Data.list
//            var hourlyDeddtail : [HourlyWeather] = []
            repeat {
                let weather = list[index].weather
                let iconImage = weather[0].icon
                let datee = list[index].dt_txt
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                guard let date = formatter.date(from: datee) else { return }
                formatter.dateFormat = "HH"
                let Hour = formatter.string(from: date)
                hhh.append(String("\(Hour):00"))
                let hourlyDetail = HourlyWeather(Hour, iconImage)
                hourlyList.append(hourlyDetail)
//                print(hourlyDeddtail)
                index = index + 1
            } while index < 8;
            
        }
    }
    
    
    
    let hourlyWeatherCellIdentifier = "jbkjbhgjbgj"
    
    var cellWidth: CGFloat = 0
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = edgeSpacing
        layout.scrollDirection = .horizontal
        let cl = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cl.backgroundColor = .clear
        cl.clipsToBounds = true
        cl.delegate = self
        cl.dataSource = self
        cl.register(HourlyWeatherCollectionCell.self, forCellWithReuseIdentifier: hourlyWeatherCellIdentifier)
        cl.isPagingEnabled = true
        cl.showsHorizontalScrollIndicator = false
        cl.translatesAutoresizingMaskIntoConstraints = false
        return cl
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .tableViewBackgroundColor
        cellWidth = (contentView.frame.size.width - (edgeSpacing * 6))/4
        setupConstraint()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           let aka = self.hourlyList.prefix(8)
            for item in aka {
                self.hourData.append(item)
            }
            let kak = self.hhh.prefix(8)
            for item in kak {
                self.hourList.append(item)
            }
            print(self.hourData)
            
            print(self.hourList)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.collectionView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.currentIndex()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - comparing current time with array of times to get the current Index
    func currentIndex() {
        var Index = 0
        let times = hourList
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let currentTime = String("\(hour):\(minutes)")
        print(currentTime)
        for time in times {
            if Index < 7 {
                let time = times[Index]
                let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm"

//                let currentDate = formatter.date(from: currentTime)!
//                let date = formatter.date(from: time)!
//                let elapsedTime = date.timeIntervalSince(currentDate)
//                let hours = floor(elapsedTime / 60 / 60)
//                let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
//                print("\(Int(hours)) hr and \(Int(minutes)) min")
//                Index = Index + 1
            }
            
        }
        
//        print(currentTime)
        
    }
    
    //MARK: - setting up constraint for collectionView
    fileprivate func setupConstraint() {
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }
}


extension HourlyWeatherTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hourlyWeatherCellIdentifier, for: indexPath) as! HourlyWeatherCollectionCell
        cell.timeLbl.text =  "\(hourData[indexPath.item].hour):00"
        if indexPath.item == 0 {
            cell.iconView.backgroundColor = .customPurple   
        }
        let image = hourData[indexPath.row].icon
        cell.weatherIconImage.image = UIImage(named: "\(image)") ?? UIImage(named: "")
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (edgeSpacing), bottom: 0, right: (edgeSpacing))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: collectionView.frame.size.height * 0.98)
    }
    
}
