//
//  TabbarController.swift
//  weather
//
//  Created by Ali Aghajani on 10/1/20.
//

import Foundation
import UIKit


var edgeSpacing: CGFloat = 0
var headerHeight: CGFloat = 0

class TabbarController: BubbleTabBarController {
    
    //MARK: - Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        
        let cityUrl = URL(string: "https://weathercase-99549.firebaseio.com/.json")!
//        let cityResource = Resource<[CityViewModel]>(url: cityUrl) { data in
//            let cityVM = try? JSONDecoder().decode([CityViewModel].self, from: data)
//            return cityVM
//        }
        
//        Webservice().loadCities(url: cityUrl) {_ in
//            
//        }
//        
//        Webservice().load(resource: cityResource) { result in
//            
//        }
        
        
//        CBTabBarItem.
        self.tabBar.tintColor = .purplyBlue
//        self.tabBar.backgroundColor = .purplyBlue
        edgeSpacing = view.frame.size.width * 0.048
        headerHeight = view.frame.size.height * 0.03
    }
    
    
    //MARK: - setting up initial controllers
    func setupTabbar() {
        tabBar.layer.shadowColor   = UIColor.gray.cgColor
        tabBar.layer.shadowOffset  = CGSize(width: 2, height: 4)
        tabBar.layer.shadowRadius  = 6
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.cornerRadius = 12
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        
        let mainC = MainController()
        let mainController = UINavigationController(rootViewController: mainC)
        mainController.tabBarItem.image = UIImage(named: "mainPageIcon")
        if #available(iOS 13.0, *) {
            mainController.tabBarItem.image?.withTintColor(.purplyBlue)
        } else {
            // Fallback on earlier versions
        }
        
        mainC.title = "Anasayfa"
//        mainController
        
        let citiesC = CityListController()
        let cityListController = UINavigationController(rootViewController: citiesC)
        cityListController.tabBarItem.image = UIImage(named: "cities")
        citiesC.title = "Şehirler"
        
        
        viewControllers = [mainController, cityListController]
    }
    
}
