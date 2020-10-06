//
//  CityListControiller.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import Foundation
import UIKit

class CityListController: UIViewController {
    //MARK: - Properties
    
    let minimumCellCount = 1
    
    var cityList: [CityID]?  {
        didSet {
        }
    }
    var loadedCitList: CitiesQuickInfo = CitiesQuickInfo(cities: [])
    var totalIndex = 0
    var cityData: [CityQuickDetail] = []
    
    var weatherData: WeatherModel?
    var cityDetail: CityQuickDetail?
    let cityQuickDetailCellIdentifier = "hgjkgkvjhv"
    var cityIDs: [Int] = []
    var isEditBtnTapped = false
    var isEditModeOn = false
    
    var editBtn: UIButton = {
        var b = UIButton(type: .custom)
        b.setTitle("Düzenle", for: .normal)
        b.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 12)
        b.setTitleColor(UIColor.customPurple, for: .normal)
        b.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        b.isUserInteractionEnabled = true
        return b
    }()
    
    var addBtn: UIButton = {
        var b = UIButton(type: .custom)
        b.setImage(UIImage(named: "add"), for: .normal)
        b.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        b.isUserInteractionEnabled = true
        return b
    }()
    
    lazy var mainTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(CityQuickDetailTableCell.self, forCellReuseIdentifier: cityQuickDetailCellIdentifier)
        tv.separatorStyle = .none
        tv.clipsToBounds = true
        
        tv.allowsSelection = false
        tv.backgroundColor = .tableViewBackgroundColor
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBAr()
        cityData.removeAll()
        cityList?.removeAll()
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        loadWeather()
    }
    
    func configureView() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.loadedCitList.cities = self.cityData
            print("\n\n\n\n\n\n\n LOADEDCITYLIST IS: \(self.loadedCitList.cities) \n\n\n\n\n\n\n")
            self.mainTableView.reloadData()
        }
    }
    
    
    
    //MARK: - retrieve cities that user added and load cities weather inf
    func loadWeather()  {
        cityList = CoreDataMnager.shared.loadCityIDs()
        if let list = cityList {
            for (index, _) in list.enumerated() {
                Webservice().loadWeatherInformation(cityID: Int(list[index].id)) { result in
                    if let existedResult = result {
                        self.weatherData = existedResult
                        let firstResult =  existedResult.list[0]
                        let data = CityQuickDetail(existedResult.city.name, firstResult.dt_txt, firstResult.main.temp, firstResult.weather[0].icon)
                        print("\n\n\n\n\n\n\n data is: \(data) \n\n\n\n\n\n\n")
                        self.cityData.append(data)
                        print("\n\n\n\n\n\n\n data list is: \(self.cityData) \n\n\n\n\n\n\n")
                    }
                }
            }
            configureView()
            
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//                self.mainTableView.reloadData()
//            }
//            self.loadedCitList.cities = self.cityData
//            print("\n\n\n\n\n\n\n LOADEDCITYLIST IS: \(self.loadedCitList.cities) \n\n\n\n\n\n\n")

            
        }
    }
    
    //MARK: - setting up Nav Bar
    func setupNavBAr() {
        let textLble = UILabel(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
        textLble.text = "Şehirler"
        textLble.textColor = .slate
        textLble.textAlignment = .center
        textLble.font = UIFont(name: "Roboto-Medium", size: 16)
        self.navigationItem.titleView = textLble
        
        let leftBtn  = UIBarButtonItem(customView: editBtn)
        leftBtn.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCellEditing)))
        let rightBtn = UIBarButtonItem(customView: addBtn)
        rightBtn.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToAddCityController)))
        self.navigationItem.setLeftBarButton(leftBtn, animated: true)
        self.navigationItem.setRightBarButton(rightBtn, animated: true)
    }
    
    
    //MARK: - handling drag and drop and delete actions when user tapped on Düzenle button
    @objc func handleCellEditing() {
//        if mainTableView.isEditing {
//            editBtn.setTitle("Düzenle", for: .normal)
//            mainTableView.isEditing = false
//        } else {
//            editBtn.setTitle("Bitti", for: .normal)
//            mainTableView.isEditing = true
//        }
    }
    //MARK: -
    @objc func goToAddCityController() {
        let addCityController = AddCityController()
        navigationController?.pushViewController(addCityController, animated: true)
    }
    
    //MARK: - removing row frome tableview handling function
    func removeRow(_ withID: Int) {
        
        print("//////// before number: \(cityList?.count)")
        CoreDataMnager.shared.deleteCityName((cityList?[withID])!)
        cityData.removeAll()
        cityList?.removeAll()
        self.cityList? = CoreDataMnager.shared.loadCityIDs()
        print("//////// after number: \(cityList?.count)")
        loadWeather()
    }
    
    
    //MARK: - seting up constraints
    func setupConstraint() {
        view.addSubview(mainTableView)
        //        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            //            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            //            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            //            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

//extension CityListController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cityData.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cityQuickDetailCellIdentifier, for: indexPath) as! CityquickDetailCollectionCell
//        cell.isEditModeOn = isEditModeOn
//        let cityInf = cityData[indexPath.row]
//        cell.cityNameLbl.text = cityInf.cityName
//        cell.weatherDegreeLbl.text =  "\(Int(cityInf.temp))°C"
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        guard let date = formatter.date(from: cityInf.date) else { return UICollectionViewCell() }
//        formatter.dateFormat = "yyyy"
//        let year = formatter.string(from: date)
//        formatter.dateFormat = "MM"
//        let month = formatter.string(from: date)
//        formatter.dateFormat = "dd"
//        let day = formatter.string(from: date)
//        cell.dateLbl.text = "\(month)/\(day)/\(year)"
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.size.width, height: view.frame.size.height * 0.1)
//    }
//}


extension CityListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let city =  cityData[sourceIndexPath.section]
//        loadedCitList.cities.remove(at: sourceIndexPath.row)
//        loadedCitList.cities.insert(city, at: destinationIndexPath.section)
//
//    }
//
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return loadedCitList.cities.count
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: cityQuickDetailCellIdentifier) as! CityQuickDetailTableCell
        //        let cityInf = cityList[indexPath.row]
        //        cell.cityNameLbl.text = cityInf.cityName
        //        cell.weatherDegreeLbl.text =  "\(Int(cityInf.temp))°C"
        //        let formatter = DateFormatter()
        //            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //            guard let date = formatter.date(from: cityInf.date) else { return UITableViewCell() }
        //            formatter.dateFormat = "yyyy"
        //            let year = formatter.string(from: date)
        //            formatter.dateFormat = "MM"
        //            let month = formatter.string(from: date)
        //            formatter.dateFormat = "dd"
        //            let day = formatter.string(from: date)
        //        cell.selectionStyle = .none
        //        cell.dateLbl.text = "\(month)/\(day)/\(year)"
        //        return cell
        //        cell.isEditModeOn = isEditModeOn
        let cityInf = loadedCitList.cities[indexPath.section]
        cell.cityNameLbl.text = cityInf.cityName
        cell.weatherDegreeLbl.text =  "\(Int(cityInf.temp))°C"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: cityInf.date) else { return UITableViewCell() }
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        cell.dateLbl.text = "\(month)/\(day)/\(year)"
        cell.backgroundColor = .white
        cell.weatherIconImage.image = UIImage(named: "\(cityInf.icon)") ?? UIImage(named: "")
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? CityQuickDetailTableCell else { return }
//        //            cell.layer.cornerRadius = 13
//
//        if editingStyle == .delete {
//            let deleteAction = UIContextualAction(style: .normal, title: "Sil") { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//
//            }
//        }
//
//    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if loadedCitList.cities.count < 2 {
            return nil
        } else {
            var deleteAction = UIContextualAction(style: .normal, title:  "Sil", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
              
                self.removeRow(indexPath.section)
                success(true)
                
            })
            deleteAction.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        }
        
    
    
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
////            cityList.
////            tableView.removeat
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            loadedCitList.cities.remove(at: indexPath.section)
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.09
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
}
