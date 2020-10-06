//
//  AddCityController.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import Foundation
import UIKit


class AddCityController: UIViewController, AddCityDelegate {
    //MARK: - Properties
    let resultCellIdentifier = "jhkkhvhjkhjv"
    let cityCellIdentifier   = "hjbjhvhjvjhv"
    let url = URL(string: "https://weathercase-99549.firebaseio.com/.json")!
    var cityList : [String] = []
    var citiesWLetters = [CitySection]()
    
    //    let CorDataManager = CoreDataMnager.shared()
    var list: [CityID] = []
    
    
    
    var cashedText: String?
    var filteredSearch = [String]()
    var searchingarray : [String] = []
    var citiesMainModel: [City] = []
    var addedCity: [String] = []
    var cityIdList: [Int] = []
    var LoadedID: [CityID] = []
    var savedCity: [String] = []
    
    var numberOfAddedCity: Int = 0
    
    var backBtn: UIButton = {
        var b = UIButton(type: .custom)
        b.setImage(UIImage(named: "back"), for: .normal)
        b.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        return b
    }()
    
    lazy var mainTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(CityTableCell.self, forCellReuseIdentifier: cityCellIdentifier)
        tv.separatorStyle = .none
        tv.clipsToBounds = true
        tv.separatorStyle = .singleLine
        tv.allowsSelection = false
        tv.delaysContentTouches = false
        tv.contentInset.top = 12
        tv.backgroundColor = .tableViewBackgroundColor
        tv.keyboardDismissMode = .onDrag
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var searchResultTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(CityTableCell.self, forCellReuseIdentifier: resultCellIdentifier)
        tv.separatorStyle = .none
        tv.clipsToBounds = true
        tv.backgroundColor = .tableViewBackgroundColor
        tv.separatorStyle = .singleLine
        tv.alpha = 0
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    lazy var SearchTextfield: UITextField = {
        let st = UITextField(frame: CGRect(x: 0, y: 0, width: 270, height: 34))
        st.backgroundColor = .paleGrey
        st.textColor = .black
        st.font = UIFont(name: "Roboto-Medium", size: 12)
        st.textAlignment = .left
        let imageView = UIImageView(frame: CGRect(x: st.frame.size.width - 30, y: 0, width: 24, height: 24))
        imageView.image = UIImage(named: "searchIcon")
        imageView.contentMode = .scaleAspectFit
        st.rightViewMode = UITextField.ViewMode.always
        st.rightView = imageView
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 10))
        view.addSubview(imageView)
        st.leftViewMode = UITextField.ViewMode.always
        st.leftView = imageView
        st.delegate = self as! UITextFieldDelegate
        st.addTarget(self, action: #selector(AddCityController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        st.layer.shadowColor   = UIColor.black.cgColor
        st.layer.shadowOffset  = CGSize(width: 0.1, height: 0.1)
        st.layer.shadowRadius  = 1
        st.layer.shadowOpacity = 0.1
        st.clipsToBounds       = false
        st.layer.cornerRadius = 6
        return st
    }()
    
    
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(isFirstTime: isFirstTimeEnteredApp)
        setupConstraint()
        view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.loadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        loadData()
        
        
        let data = CoreDataMnager.shared.loadCityIDs()
        print("Data Is --- > \n \n \n \(data.count) - - \n\n\n")
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    
    //MARK: - loading city list
    func loadData() {
        Webservice().loadCities(url: url) { result in
            if let resul = result {
                for item in resul {
                    self.citiesMainModel.append(item)
                    let cityName = item.name
                    
                    self.cityList.append(cityName)
                }
                self.groupingCitiesAlphabeticaly(citiesList: self.cityList)
                self.turnIdIntoCityName()
            }
        }
    }
    
    //MARK: - turning Id into city name for other
    func turnIdIntoCityName() {
        LoadedID  = CoreDataMnager.shared.loadCityIDs()
        for id in LoadedID {
            for item in citiesMainModel {
                if item.id == Int(id.id) {
                    savedCity.append(item.name)
                }
            }
        }
    }
    
    //MARK: - sortin cities by alphabet function
    func groupingCitiesAlphabeticaly(citiesList: [String]){
        var citiesWithLetters = [CitySection]()
        let groupeddictionary = Dictionary(grouping: citiesList, by: {String($0.prefix(1))})
        let keys = groupeddictionary.keys.sorted()
        citiesWithLetters = keys.map{CitySection(letter: $0, cities: groupeddictionary[$0]!.sorted())}
        citiesWLetters = citiesWithLetters
        mainTableView.reloadData()
        mergeDict(cityDictionary: citiesWithLetters)
    }
    
    //MARK: - merging all the city names in dictionary into an array for search
    func mergeDict(cityDictionary: [CitySection]){
        for item in cityDictionary {
            for cityName in item.cities {
                searchingarray.append(cityName)
            }
        }
        
    }
    
    //MARK: - handling tableview switch when user taped on serach bar
    func showResult() {
        searchResultTableView.alpha = 1
        mainTableView.alpha = 0
    }
    
    //MARK: - TextFieldDidChange Custom Delegate Method
    @objc func textFieldDidChange(_ textField: UITextField) {
        filteredSearch = searchingarray.filter({ (result) -> Bool in
            return result.lowercased().contains(textField.text!.lowercased()) ?? false
            searchResultTableView.reloadData()
        })
        if textField.text!.isEmpty && filteredSearch.isEmpty {
            filteredSearch = searchingarray
        }
        cashedText = textField.text
        
        searchResultTableView.reloadData()
        showResult()
        
    }
    
    
    //MARK: -
    @objc func handleBack() {
        //        UserDefaultStruct.standardUserDefault.set(LoadedID, forKey: "cityIdList")
        //        UserDefaultStruct.standardUserDefault.synchronize()
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - seting up NavBar
    func setupNavBar(isFirstTime: Bool) {
        if isFirstTime {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                let popUp = InitialPopUp()
                self.view.addSubview(popUp)
            }
            let righSearchBar = UIBarButtonItem(customView: SearchTextfield)
            self.navigationItem.setRightBarButton(righSearchBar, animated: true)
        } else {
            let leftBtn  = UIBarButtonItem(customView: backBtn)
            let righSearchBar = UIBarButtonItem(customView: SearchTextfield)
            leftBtn.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
            self.navigationItem.setRightBarButton(righSearchBar, animated: true)
            self.navigationItem.setLeftBarButton(leftBtn, animated: true)
        }
    }
    
    
    
    
    
    
    //MARK: - handlin saving cityId to coreData Model
    func saveCityID(_ cityName: String) {
        if savedCity.contains(cityName) {
            let popUp = SuccesAddedCityPopUp()
            popUp.BackgroundImage.image = UIImage(named: "failed")
            popUp.headerLabel.text = "This city is already in your list"
            view.addSubview(popUp)
        } else {
            for item in citiesMainModel {
                if item.name.contains(cityName) {
                    let popUp = SuccesAddedCityPopUp()
                    popUp.BackgroundImage.image = UIImage(named: "success")
                    savedCity.append(cityName)
                    view.addSubview(popUp)
                    CoreDataMnager.shared.createCityID(item.id, cityName: item.name)
                    print(CoreDataMnager.shared.loadCityIDs().count)
                    numberOfAddedCity = numberOfAddedCity + 1
                    print(numberOfAddedCity)
                }
            }
        }
    }
    
    //MARK: - seting up constraints
    func setupConstraint() {
        view.addSubview(mainTableView)
        view.addSubview(searchResultTableView)
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            searchResultTableView.topAnchor.constraint(equalTo: view.topAnchor),
            searchResultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchResultTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchResultTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}


extension AddCityController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case mainTableView:
            return citiesWLetters.count
        case searchResultTableView:
            return 1
        default:
            0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case mainTableView:
            return citiesWLetters[section].cities.count
        case searchResultTableView:
            return filteredSearch.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case mainTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: cityCellIdentifier) as! CityTableCell
            let section = citiesWLetters[indexPath.section]
            let cityName = section.cities[indexPath.row]
            cell.handleAddingCityDelegate = self as? AddCityDelegate
            cell.cityNameLbl.text = cityName
            cell.selectionStyle = .none
            return cell
        case searchResultTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: resultCellIdentifier) as! CityTableCell
            let city = filteredSearch[indexPath.row]
            cell.cityNameLbl.text = city
            cell.handleAddingCityDelegate = self
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.07
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return citiesWLetters.map{$0.letter}
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView {
        case mainTableView:
            return view.frame.size.height * 0.02
        case searchResultTableView:
            return 0.0001
        default:
            0.001
        }
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case mainTableView:
            return citiesWLetters[section].letter
        default:
            return nil
        }
    }
}

extension AddCityController: UITextFieldDelegate {
    
}

extension AddCityController {
    
    func handleAdding(cityName: String) {
        
        if isFirstTimeEnteredApp {
            saveCityID(cityName)
            if numberOfAddedCity == 3 {
                UserDefaultStruct.standardUserDefault.set(false, forKey: "isFirstTime")
                UserDefaultStruct.standardUserDefault.synchronize()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    let mainVC = TabbarController()
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC, animated: true)
                    isFirstTimeEnteredApp = false
                }
            }
        } else {
            saveCityID(cityName)

        }
    }
}


