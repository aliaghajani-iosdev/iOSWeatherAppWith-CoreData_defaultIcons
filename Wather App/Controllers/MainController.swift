//
//  MainController.swift
//  weather
//
//  Created by Ali Aghajani on 10/1/20.
//

import Foundation
import UIKit

class MainController: UIViewController {
    
    //MARK: - Properties
    var cityIDs: [CityID] = []
    var list: [String] = []
    var cityList: [CityID]?  {
        didSet {
            mainTableView.reloadData()
        }
    }
    
    var currentCityID : Int?
    var currentPageData: WeatherModel?
    
    let weeklyDetailTableCellIdentifier = "kjbkbjbkb"
    let cityListTableCellIdentifier     = "jblkblblblb"
    let currentWeatherCellIdentifier    = "jkbjvhjvjvhj"
    let hourlyWeatherCellIdentifier     = "hujhnkjnbkj"
    let dailyDetailCellIdentifier       = "hbjhvbhjvjhv"
    let dailydetailHeaderIdentifier     = "jkbjkbjkbjj"
    
    var index = 0
    lazy var mainTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(CityListTableViewCell.self, forCellReuseIdentifier: cityListTableCellIdentifier)
        tv.register(CurrentWeatherTableCell.self, forCellReuseIdentifier: currentWeatherCellIdentifier)
        tv.register(HourlyWeatherTableCell.self, forCellReuseIdentifier: hourlyWeatherCellIdentifier)
        tv.register(DailyDetailTableCell.self, forCellReuseIdentifier: dailyDetailCellIdentifier)
        tv.register(WeeklydetailTablecell.self, forCellReuseIdentifier: weeklyDetailTableCellIdentifier)

        tv.separatorStyle = UITableViewCell.SeparatorStyle.none
        tv.separatorColor = UIColor.tableViewBackgroundColor
        tv.showsVerticalScrollIndicator = false
        tv.clipsToBounds = true
        tv.backgroundColor = .tableViewBackgroundColor
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    //MARK: - Inits
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
        view.backgroundColor = .tableViewBackgroundColor
        getCityList()
//        mainTableView.reloadData()
        print(list)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCityList()
//        cityList.suffix(index)
        setupNavBAR()
        mainTableView.reloadData()
        self.navigationController?.navigationBar.shouldRemoveShadow(true)

    }
    
    //MARK: - loading data for Main Page
    func getCityList() {
        cityList = CoreDataMnager.shared.loadCityIDs()
//        index = cityIDs.count
        if let currentId = cityList?[index].id {
            LoadData(cityId: Int(currentId))
        }
        
    }
    
    
    func LoadData(cityId: Int) {
            Webservice().loadWeatherInformation(cityID: cityId) { result in
                if let result = result {
                    self.currentPageData = result
                }
                self.mainTableView.reloadData()
            }
        }
    
    //MARK: - setting up nav bar
    func setupNavBAR() {
        let textLble = UILabel(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
        textLble.text = "Hava Durumu"
        textLble.textColor = .slate
        textLble.textAlignment = .center
        textLble.font = UIFont(name: "Roboto-Medium", size: 16)
        self.navigationItem.titleView = textLble
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    
    
    
    //MARK: - setimg up constraint programatically
    func setupConstraint() {
        view.addSubview(mainTableView)
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        ])
    }
}





extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cityListTableCellIdentifier, for: indexPath) as! CityListTableViewCell
            cell.cities = cityList
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: currentWeatherCellIdentifier, for: indexPath) as! CurrentWeatherTableCell
            cell.cellData = currentPageData
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: hourlyWeatherCellIdentifier, for: indexPath) as! HourlyWeatherTableCell
            cell.cellData = currentPageData
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: dailyDetailCellIdentifier, for: indexPath) as! DailyDetailTableCell
            cell.cellData = currentPageData
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: weeklyDetailTableCellIdentifier) as! WeeklydetailTablecell
            cell.cellData = currentPageData
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return view.frame.size.height * 0.08
        case 1:
            return view.frame.size.height * 0.24
        case 2:
            return view.frame.size.height * 0.17
        case 3:
            return view.frame.size.height * 0.23
        case 4:
            return view.frame.size.height * 0.42
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000011
    }
}

extension MainController: sendBackCityIdDelegate {
    func makeRequestWithID(_ id: Int) {
        LoadData(cityId: id)
        let index1 = IndexPath(row: 1, section: 0)
        let index2 = IndexPath(row: 2, section: 0)
        let index3 = IndexPath(row: 3, section: 0)
        let index4 = IndexPath(row: 4, section: 0)
        mainTableView.reloadRows(at: [index1,index2,index3,index4], with: .automatic)
    }
    
    
}
