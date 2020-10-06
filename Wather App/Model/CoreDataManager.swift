//
//  CoreDataManager.swift
//  weather
//
//  Created by Ali Aghajani on 10/4/20.
//

import Foundation
import CoreData

struct CoreDataMnager {
    
    //MARK: - initiate container
    static let shared = CoreDataMnager()
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Wather_App")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("there's problem with loadin stores: \(error)")
            }
        }
        return container
    }()
    
    
    
    
    //MARK: - create Object method
    func createCityID(_ cityID: Int, cityName: String) {
        let context = persistentContainer.viewContext
        let newCityId = NSEntityDescription.insertNewObject(forEntityName: "CityID", into: context) as! CityID
        newCityId.id   = Int32(cityID)
        newCityId.name = cityName
        do {
            try  context.save()
        } catch let error {
            fatalError("something is wrong with saving cit Ids, error: \(error)")
        }
    }
    //MARK: - save Objects method
//    func saveCityList(_cityList: [CityID]) {
//        let context = persistentContainer.viewContext
//        let List = NSEntityDescription.
//        
//    }
    
    //MARK: - Load Object Method
    func loadCityIDs() -> [CityID] {
        let context = persistentContainer.viewContext
        let loadRequest = NSFetchRequest <CityID>(entityName: "CityID")
        do {
            let cityList = try context.fetch(loadRequest)
            return cityList
            
        } catch let error {
            fatalError("ther is something wrong with loadin cityIDs, error: \(error)")
            return []
        }
    }
    
    //MARK: - Delete Object Method
    func deleteCityName(_ cityId: CityID) -> Bool {
        let context = persistentContainer.viewContext
        context.delete(cityId)
        do {
            try context.save()
            return true
        } catch let error {
            fatalError("Something is wrong with deletinig Object, error: \(error)")
        }
    }
}
