//
//  weeklydetailTablecell.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import Foundation
import UIKit

class WeeklydetailTablecell: UITableViewCell {
    //MARK: - Properties
    var weekdaysList: [String] = []
    var mainData: [WeeklyInfo] = []
    var dayList: [String] = []
    var tempMaxList: [String] = []
    var tempMinList: [String] = []
    var iconImageNames: [String] = []
    var maxTempList: [Double] = []
    var minTempList: [Double] = []
    var icons: [String] = []
    
    var cellData: WeatherModel? {
        didSet {
            guard let Data = cellData else {return}
            let list: [List] = Data.list
            var daysss: [Int] = []
            var diuaaaa: [String] = []
            let dayyyyy = DateFormatter()
            dayyyyy.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let dateee = dayyyyy.date(from: list[0].dt_txt) else { return }
            dayyyyy.dateFormat = "dd"
            let day = dayyyyy.string(from: dateee)
            
            
            var dates: [String] = []
            for (index, _) in list.enumerated() {
                let datee = list[index].dt_txt
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                guard let date = formatter.date(from: datee) else { return }
                formatter.dateFormat = "yyyy"
                let year = formatter.string(from: date)
                formatter.dateFormat = "MM"
                let month = formatter.string(from: date)
                formatter.dateFormat = "dd"
                let day = formatter.string(from: date)
                let extractDate = "\(year)-\(month)-\(day)"
                dates.append(extractDate)
            }
            var cccc = dates.removingDuplicates()
            cccc.removeFirst()
            var lll : [String] = []
            for item in cccc {
                let vv = getDayOfWeek(item)
                if let vvv = vv {
                    lll.append(vvv)
                }
            }
            for item in lll {
                let xssx =  turnIntoTurkishDay(item)
                weekdaysList.append(xssx)
            }

            
            var currentInd = 6
            for _ in 0...4 {
                let main = list[currentInd].main
                let weather = list[currentInd].weather
                let maxT = main.temp_max
                let minT = main.temp_min
                let icon = weather[0].icon
                maxTempList.append(maxT)
                minTempList.append(minT)
                icons.append(icon)
                print(" ---> --->\(maxT) --->\(minT) --->\(icon)")
                currentInd = currentInd + 6
            }
        }
}

lazy var headerLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "Haftalık Hava Durumu"
    lbl.textColor = .slate
    lbl.font = UIFont(name: "Roboto-Medium", size: 16)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

var firstSeparatorView: UIView = {
    let v = UIView()
    v.backgroundColor = .whiteTwo
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
}()

var secondSeparatorView: UIView = {
    let v = UIView()
    v.backgroundColor = .whiteTwo
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
}()

var thirdSeparatorView: UIView = {
    let v = UIView()
    v.backgroundColor = .whiteTwo
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
}()

var fourthSeparatorView: UIView = {
    let v = UIView()
    v.backgroundColor = .whiteTwo
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
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

// ----------------- first row's elements -----------------
lazy var firstContainer: UIView = {
    let v = UIView()
    v.backgroundColor = .clear
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
}()

lazy var firstDayLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "Salı"
    lbl.textColor = .slate
    lbl.font = UIFont(name: "Roboto-Medium", size: 16)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

var firstWeatherIconImage: UIImageView = {
    let w = UIImageView()
    w.backgroundColor = .clear
    w.image = UIImage(named: "sun")
    w.contentMode = .scaleAspectFit
    w.clipsToBounds = true
    w.translatesAutoresizingMaskIntoConstraints = false
    return w
}()

lazy var firstMaxDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .slate
    lbl.textAlignment = .center
    lbl.text = "24"
    lbl.numberOfLines = 1
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

lazy var firstMinDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "16"
    lbl.textAlignment = .center
    lbl.textColor = .blueGrey
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

// ----------------- second row's elements -----------------
lazy var secondContainer: UIView = {
    let v = UIView()
    v.backgroundColor = .clear
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
}()

lazy var secondDayLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "Salı"
    lbl.textColor = .slate
    lbl.font = UIFont(name: "Roboto-Medium", size: 16)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

var secondWeatherIconImage: UIImageView = {
    let w = UIImageView()
    w.backgroundColor = .clear
    w.image = UIImage(named: "sun")
    w.contentMode = .scaleAspectFit
    w.clipsToBounds = true
    w.translatesAutoresizingMaskIntoConstraints = false
    return w
}()

lazy var secondMaxDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .slate
    lbl.textAlignment = .center
    lbl.text = "24"
    lbl.numberOfLines = 1
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

lazy var secondMinDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "16"
    lbl.textAlignment = .center
    lbl.textColor = .blueGrey
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()



// ----------------- third row's elements -----------------
lazy var thirdContainer: UIView = {
    let v = UIView()
    v.backgroundColor = .clear
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
}()

lazy var thirdDayLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "Salı"
    lbl.textColor = .slate
    lbl.font = UIFont(name: "Roboto-Medium", size: 16)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

var thirdWeatherIconImage: UIImageView = {
    let w = UIImageView()
    w.backgroundColor = .clear
    w.image = UIImage(named: "sun")
    w.contentMode = .scaleAspectFit
    w.clipsToBounds = true
    w.translatesAutoresizingMaskIntoConstraints = false
    return w
}()

lazy var thirdMaxDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .slate
    lbl.textAlignment = .center
    lbl.text = "24"
    lbl.numberOfLines = 1
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

lazy var thirdMinDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "16"
    lbl.textAlignment = .center
    lbl.textColor = .blueGrey
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()


// ----------------- fourth row's elements -----------------
lazy var fourthContainer: UIView = {
    let v = UIView()
    v.backgroundColor = .clear
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
}()

lazy var fourthDayLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "Salı"
    lbl.textColor = .slate
    lbl.font = UIFont(name: "Roboto-Medium", size: 16)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

var fourthWeatherIconImage: UIImageView = {
    let w = UIImageView()
    w.backgroundColor = .clear
    w.image = UIImage(named: "sun")
    w.contentMode = .scaleAspectFit
    w.clipsToBounds = true
    w.translatesAutoresizingMaskIntoConstraints = false
    return w
}()

lazy var fourthMaxDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .slate
    lbl.textAlignment = .center
    lbl.text = "24"
    lbl.numberOfLines = 1
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

lazy var fourthMinDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "16"
    lbl.textAlignment = .center
    lbl.textColor = .blueGrey
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()


// ----------------- fifth row's elements -----------------
lazy var fifthContainer: UIView = {
    let v = UIView()
    v.backgroundColor = .clear
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
}()

lazy var fifthDayLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "Salı"
    lbl.textColor = .slate
    lbl.font = UIFont(name: "Roboto-Medium", size: 16)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

var fifthWeatherIconImage: UIImageView = {
    let w = UIImageView()
    w.backgroundColor = .clear
    w.image = UIImage(named: "sun")
    w.contentMode = .scaleAspectFit
    w.clipsToBounds = true
    w.translatesAutoresizingMaskIntoConstraints = false
    return w
}()

lazy var fifthMaxDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .slate
    lbl.textAlignment = .center
    lbl.text = "24"
    lbl.numberOfLines = 1
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()

lazy var fifthMinDegreeLbl: UILabel = {
    let lbl = UILabel()
    lbl.numberOfLines = 1
    lbl.text = "16"
    lbl.textAlignment = .center
    lbl.textColor = .blueGrey
    lbl.font = UIFont(name: "Roboto-Medium", size: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
}()


//MARk: - Init
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupConstraint()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        self.createModel()
    }
    
    backgroundColor = .tableViewBackgroundColor
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

//MARK: -
func getDayOfWeek(_ date: String) -> String?
{ Formatter.customDate.date(from: date)?.weekdayName }

//MARK: - Getting List Of week days
func turnIntoTurkishDay(_ dayOfTheWeek: String) -> String {
    switch dayOfTheWeek {
    case "Sunday":
        return "Pazar"
    case "Monday":
        return "Pazartesi"
    case "Tuesday":
        return "Salı"
    case "Wednesday":
        return "Çarşamba"
    case "Thursday":
        return "Perşembe"
    case "Friday":
        return "Cuma"
    case "Saturday":
        return "Cumartesi"
        
    default:
        return "something is wrong with converting into turkish days"
    }
}

func gettListOfWeekDay(_ index: Int) -> String {
    var week = Calendar.current.weekdaySymbols
    week.removeFirst()
    return turnIntoTurkishDay(week[index])
    
    
}

//MARK: minuplating data at the final stage and addind data in to view elements
func createModel() {
    var currentIndexx = 0
        for _ in maxTempList {
        if currentIndexx < maxTempList.count {
            let weeklyModel = WeeklyInfo(weekdaysList[currentIndexx], maxTempList[currentIndexx], minTempList[currentIndexx], icons[currentIndexx])
            //                print(weeklyModel)
            mainData.append(weeklyModel)
            currentIndexx = currentIndexx + 1
        }
    }
    
    if mainData.count > 1 {
        firstDayLbl.text = mainData[0].dayName
        firstMaxDegreeLbl.text = "\(String(Int(mainData[0].maxTemp)))°"
        firstMinDegreeLbl.text = "\(String(Int(mainData[0].minTemp)))°"
        firstWeatherIconImage.image = UIImage(named: "\(mainData[0].icon)") ?? UIImage(named: "")
        
        secondDayLbl.text = mainData[1].dayName
        secondMaxDegreeLbl.text = "\(String(Int(mainData[1].maxTemp)))°"
        secondMinDegreeLbl.text = "\(String(Int(mainData[1].minTemp)))°"
        secondWeatherIconImage.image = UIImage(named: "\(mainData[1].icon)") ?? UIImage(named: "")
        
        thirdDayLbl.text = mainData[2].dayName
        thirdMaxDegreeLbl.text = "\(String(Int(mainData[2].maxTemp)))°"
        thirdMinDegreeLbl.text = "\(String(Int(mainData[2].minTemp)))°"
        thirdWeatherIconImage.image = UIImage(named: "\(mainData[2].icon)") ?? UIImage(named: "")
        
        fourthDayLbl.text = mainData[3].dayName
        fourthMaxDegreeLbl.text = "\(String(Int(mainData[3].maxTemp)))°"
        fourthMinDegreeLbl.text = "\(String(Int(mainData[3].minTemp)))°"
        fourthWeatherIconImage.image = UIImage(named: "\(mainData[3].icon)") ?? UIImage(named: "")
        
        fifthDayLbl.text = mainData[4].dayName
        fifthMaxDegreeLbl.text = "\(String(Int(mainData[4].maxTemp)))°"
        fifthMinDegreeLbl.text = "\(String(Int(mainData[4].minTemp)))°"
        fifthWeatherIconImage.image = UIImage(named: "\(mainData[4].icon)") ?? UIImage(named: "")
    }
    
    
}


//MARK: - seting up Constraints
func setupConstraint() {
    contentView.addSubview(headerLbl)
    contentView.addSubview(mainView)
    
    mainView.addSubview(firstSeparatorView)
    mainView.addSubview(secondSeparatorView)
    mainView.addSubview(thirdSeparatorView)
    mainView.addSubview(fourthSeparatorView)
    
    mainView.addSubview(firstContainer)
    mainView.addSubview(secondContainer)
    mainView.addSubview(thirdContainer)
    mainView.addSubview(fourthContainer)
    mainView.addSubview(fifthContainer)
    
    
    firstContainer.addSubview(firstDayLbl)
    firstContainer.addSubview(firstMinDegreeLbl)
    firstContainer.addSubview(firstMaxDegreeLbl)
    firstContainer.addSubview(firstWeatherIconImage)
    
    secondContainer.addSubview(secondDayLbl)
    secondContainer.addSubview(secondMinDegreeLbl)
    secondContainer.addSubview(secondMaxDegreeLbl)
    secondContainer.addSubview(secondWeatherIconImage)
    
    
    thirdContainer.addSubview(thirdDayLbl)
    thirdContainer.addSubview(thirdMinDegreeLbl)
    thirdContainer.addSubview(thirdMaxDegreeLbl)
    thirdContainer.addSubview(thirdWeatherIconImage)
    
    fourthContainer.addSubview(fourthDayLbl)
    fourthContainer.addSubview(fourthMinDegreeLbl)
    fourthContainer.addSubview(fourthMaxDegreeLbl)
    fourthContainer.addSubview(fourthWeatherIconImage)
    
    fifthContainer.addSubview(fifthDayLbl)
    fifthContainer.addSubview(fifthMinDegreeLbl)
    fifthContainer.addSubview(fifthMaxDegreeLbl)
    fifthContainer.addSubview(fifthWeatherIconImage)
    
    NSLayoutConstraint.activate([
        
        headerLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: edgeSpacing),
        headerLbl.heightAnchor.constraint(equalToConstant: headerHeight),
        headerLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
        headerLbl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
        
        mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: edgeSpacing),
        mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -edgeSpacing),
        mainView.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: 10),
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        
        // third container and elements
        thirdContainer.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
        thirdContainer.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        thirdContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor),
        thirdContainer.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.17),
        
        thirdDayLbl.leftAnchor.constraint(equalTo: thirdContainer.leftAnchor, constant: edgeSpacing),
        thirdDayLbl.centerYAnchor.constraint(equalTo: thirdContainer.centerYAnchor),
        thirdDayLbl.heightAnchor.constraint(equalTo: thirdContainer.heightAnchor, multiplier: 0.72),
        thirdDayLbl.widthAnchor.constraint(equalTo: thirdContainer.widthAnchor, multiplier: 0.28),
        
        thirdMinDegreeLbl.rightAnchor.constraint(equalTo: thirdContainer.rightAnchor, constant: -edgeSpacing),
        thirdMinDegreeLbl.heightAnchor.constraint(equalTo: thirdContainer.heightAnchor, multiplier: 0.72),
        thirdMinDegreeLbl.centerYAnchor.constraint(equalTo: thirdContainer.centerYAnchor),
        thirdMinDegreeLbl.widthAnchor.constraint(equalTo: thirdContainer.widthAnchor, multiplier: 0.08),
        
        thirdMaxDegreeLbl.rightAnchor.constraint(equalTo: thirdMinDegreeLbl.leftAnchor, constant: -4),
        thirdMaxDegreeLbl.heightAnchor.constraint(equalTo: thirdContainer.heightAnchor, multiplier: 0.72),
        thirdMaxDegreeLbl.centerYAnchor.constraint(equalTo: thirdContainer.centerYAnchor),
        thirdMaxDegreeLbl.widthAnchor.constraint(equalTo: thirdContainer.widthAnchor, multiplier: 0.08),
        
        thirdWeatherIconImage.rightAnchor.constraint(equalTo: thirdMaxDegreeLbl.leftAnchor, constant: -4),
        thirdWeatherIconImage.heightAnchor.constraint(equalTo: thirdContainer.heightAnchor, multiplier: 0.66),
        thirdWeatherIconImage.centerYAnchor.constraint(equalTo: thirdContainer.centerYAnchor),
        thirdWeatherIconImage.widthAnchor.constraint(equalTo: thirdContainer.widthAnchor, multiplier: 0.10),
        
        
        secondSeparatorView.heightAnchor.constraint(equalToConstant: 0.7),
        secondSeparatorView.bottomAnchor.constraint(equalTo: thirdContainer.topAnchor),
        secondSeparatorView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: edgeSpacing),
        secondSeparatorView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -edgeSpacing),
        
        thirdSeparatorView.heightAnchor.constraint(equalToConstant: 0.7),
        thirdSeparatorView.topAnchor.constraint(equalTo: thirdContainer.bottomAnchor),
        thirdSeparatorView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: edgeSpacing),
        thirdSeparatorView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -edgeSpacing),
        
        
        // fourth container and elements
        fourthContainer.topAnchor.constraint(equalTo: thirdSeparatorView.bottomAnchor),
        fourthContainer.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        fourthContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor),
        fourthContainer.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.17),
        
        fourthDayLbl.leftAnchor.constraint(equalTo: fourthContainer.leftAnchor, constant: edgeSpacing),
        fourthDayLbl.centerYAnchor.constraint(equalTo: fourthContainer.centerYAnchor),
        fourthDayLbl.heightAnchor.constraint(equalTo: fourthContainer.heightAnchor, multiplier: 0.72),
        fourthDayLbl.widthAnchor.constraint(equalTo: fourthContainer.widthAnchor, multiplier: 0.28),
        
        fourthMinDegreeLbl.rightAnchor.constraint(equalTo: fourthContainer.rightAnchor, constant: -edgeSpacing),
        fourthMinDegreeLbl.heightAnchor.constraint(equalTo: fourthContainer.heightAnchor, multiplier: 0.72),
        fourthMinDegreeLbl.centerYAnchor.constraint(equalTo: fourthContainer.centerYAnchor),
        fourthMinDegreeLbl.widthAnchor.constraint(equalTo: fourthContainer.widthAnchor, multiplier: 0.08),
        
        fourthMaxDegreeLbl.rightAnchor.constraint(equalTo: fourthMinDegreeLbl.leftAnchor, constant: -4),
        fourthMaxDegreeLbl.heightAnchor.constraint(equalTo: fourthContainer.heightAnchor, multiplier: 0.72),
        fourthMaxDegreeLbl.centerYAnchor.constraint(equalTo: fourthContainer.centerYAnchor),
        fourthMaxDegreeLbl.widthAnchor.constraint(equalTo: fourthContainer.widthAnchor, multiplier: 0.08),
        
        fourthWeatherIconImage.rightAnchor.constraint(equalTo: fourthMaxDegreeLbl.leftAnchor, constant: -4),
        fourthWeatherIconImage.heightAnchor.constraint(equalTo: fourthContainer.heightAnchor, multiplier: 0.66),
        fourthWeatherIconImage.centerYAnchor.constraint(equalTo: fourthContainer.centerYAnchor),
        fourthWeatherIconImage.widthAnchor.constraint(equalTo: fourthContainer.widthAnchor, multiplier: 0.10),
        
        
        fourthSeparatorView.heightAnchor.constraint(equalToConstant: 0.7),
        fourthSeparatorView.topAnchor.constraint(equalTo: fourthContainer.bottomAnchor),
        fourthSeparatorView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: edgeSpacing),
        fourthSeparatorView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -edgeSpacing),
        
        
        // fifth container and elements
        fifthContainer.topAnchor.constraint(equalTo: fourthSeparatorView.bottomAnchor),
        fifthContainer.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        fifthContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor),
        fifthContainer.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.17),
        
        fifthDayLbl.leftAnchor.constraint(equalTo: fifthContainer.leftAnchor, constant: edgeSpacing),
        fifthDayLbl.centerYAnchor.constraint(equalTo: fifthContainer.centerYAnchor),
        fifthDayLbl.heightAnchor.constraint(equalTo: fifthContainer.heightAnchor, multiplier: 0.72),
        fifthDayLbl.widthAnchor.constraint(equalTo: fifthContainer.widthAnchor, multiplier: 0.28),
        
        fifthMinDegreeLbl.rightAnchor.constraint(equalTo: fifthContainer.rightAnchor, constant: -edgeSpacing),
        fifthMinDegreeLbl.heightAnchor.constraint(equalTo: fifthContainer.heightAnchor, multiplier: 0.72),
        fifthMinDegreeLbl.centerYAnchor.constraint(equalTo: fifthContainer.centerYAnchor),
        fifthMinDegreeLbl.widthAnchor.constraint(equalTo: fifthContainer.widthAnchor, multiplier: 0.08),
        
        fifthMaxDegreeLbl.rightAnchor.constraint(equalTo: fifthMinDegreeLbl.leftAnchor, constant: -4),
        fifthMaxDegreeLbl.heightAnchor.constraint(equalTo: fifthContainer.heightAnchor, multiplier: 0.72),
        fifthMaxDegreeLbl.centerYAnchor.constraint(equalTo: fifthContainer.centerYAnchor),
        fifthMaxDegreeLbl.widthAnchor.constraint(equalTo: fifthContainer.widthAnchor, multiplier: 0.08),
        
        fifthWeatherIconImage.rightAnchor.constraint(equalTo: fifthMaxDegreeLbl.leftAnchor, constant: -4),
        fifthWeatherIconImage.heightAnchor.constraint(equalTo: fifthContainer.heightAnchor, multiplier: 0.66),
        fifthWeatherIconImage.centerYAnchor.constraint(equalTo: fifthContainer.centerYAnchor),
        fifthWeatherIconImage.widthAnchor.constraint(equalTo: fifthContainer.widthAnchor, multiplier: 0.10),
        
        
        
        // second container and elements
        secondContainer.bottomAnchor.constraint(equalTo: secondSeparatorView.topAnchor),
        secondContainer.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        secondContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor),
        secondContainer.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.17),
        
        secondDayLbl.leftAnchor.constraint(equalTo: secondContainer.leftAnchor, constant: edgeSpacing),
        secondDayLbl.centerYAnchor.constraint(equalTo: secondContainer.centerYAnchor),
        secondDayLbl.heightAnchor.constraint(equalTo: secondContainer.heightAnchor, multiplier: 0.72),
        secondDayLbl.widthAnchor.constraint(equalTo: secondContainer.widthAnchor, multiplier: 0.28),
        
        secondMinDegreeLbl.rightAnchor.constraint(equalTo: secondContainer.rightAnchor, constant: -edgeSpacing),
        secondMinDegreeLbl.heightAnchor.constraint(equalTo: secondContainer.heightAnchor, multiplier: 0.72),
        secondMinDegreeLbl.centerYAnchor.constraint(equalTo: secondContainer.centerYAnchor),
        secondMinDegreeLbl.widthAnchor.constraint(equalTo: secondContainer.widthAnchor, multiplier: 0.08),
        
        secondMaxDegreeLbl.rightAnchor.constraint(equalTo: secondMinDegreeLbl.leftAnchor, constant: -4),
        secondMaxDegreeLbl.heightAnchor.constraint(equalTo: secondContainer.heightAnchor, multiplier: 0.72),
        secondMaxDegreeLbl.centerYAnchor.constraint(equalTo: secondContainer.centerYAnchor),
        secondMaxDegreeLbl.widthAnchor.constraint(equalTo: secondContainer.widthAnchor, multiplier: 0.08),
        
        secondWeatherIconImage.rightAnchor.constraint(equalTo: secondMaxDegreeLbl.leftAnchor, constant: -4),
        secondWeatherIconImage.heightAnchor.constraint(equalTo: secondContainer.heightAnchor, multiplier: 0.66),
        secondWeatherIconImage.centerYAnchor.constraint(equalTo: secondContainer.centerYAnchor),
        secondWeatherIconImage.widthAnchor.constraint(equalTo: secondContainer.widthAnchor, multiplier: 0.10),
        
        
        firstSeparatorView.heightAnchor.constraint(equalToConstant: 0.7),
        firstSeparatorView.bottomAnchor.constraint(equalTo: secondContainer.topAnchor),
        firstSeparatorView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: edgeSpacing),
        firstSeparatorView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -edgeSpacing),
        
        
        // first container and elements
        firstContainer.bottomAnchor.constraint(equalTo: firstSeparatorView.topAnchor),
        firstContainer.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        firstContainer.widthAnchor.constraint(equalTo: mainView.widthAnchor),
        firstContainer.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.17),
        
        firstDayLbl.leftAnchor.constraint(equalTo: firstContainer.leftAnchor, constant: edgeSpacing),
        firstDayLbl.centerYAnchor.constraint(equalTo: firstContainer.centerYAnchor),
        firstDayLbl.heightAnchor.constraint(equalTo: firstContainer.heightAnchor, multiplier: 0.72),
        firstDayLbl.widthAnchor.constraint(equalTo: firstContainer.widthAnchor, multiplier: 0.28),
        
        firstMinDegreeLbl.rightAnchor.constraint(equalTo: firstContainer.rightAnchor, constant: -edgeSpacing),
        firstMinDegreeLbl.heightAnchor.constraint(equalTo: firstContainer.heightAnchor, multiplier: 0.72),
        firstMinDegreeLbl.centerYAnchor.constraint(equalTo: firstContainer.centerYAnchor),
        firstMinDegreeLbl.widthAnchor.constraint(equalTo: firstContainer.widthAnchor, multiplier: 0.08),
        
        firstMaxDegreeLbl.rightAnchor.constraint(equalTo: firstMinDegreeLbl.leftAnchor, constant: -4),
        firstMaxDegreeLbl.heightAnchor.constraint(equalTo: firstContainer.heightAnchor, multiplier: 0.72),
        firstMaxDegreeLbl.centerYAnchor.constraint(equalTo: firstContainer.centerYAnchor),
        firstMaxDegreeLbl.widthAnchor.constraint(equalTo: firstContainer.widthAnchor, multiplier: 0.08),
        
        firstWeatherIconImage.rightAnchor.constraint(equalTo: firstMaxDegreeLbl.leftAnchor, constant: -4),
        firstWeatherIconImage.heightAnchor.constraint(equalTo: firstContainer.heightAnchor, multiplier: 0.66),
        firstWeatherIconImage.centerYAnchor.constraint(equalTo: firstContainer.centerYAnchor),
        firstWeatherIconImage.widthAnchor.constraint(equalTo: firstContainer.widthAnchor, multiplier: 0.10),
    ])
}
}
