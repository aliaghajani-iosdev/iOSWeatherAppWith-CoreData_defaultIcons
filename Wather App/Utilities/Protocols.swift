//
//  Protocols.swift
//  weather
//
//  Created by Ali Aghajani on 10/2/20.
//

import Foundation
import UIKit



protocol AddCityDelegate {
    func handleAdding(cityName: String)
}

protocol SendingBackIndexAndIDDelegate {
    func makeNiewRequest(_ index: Int, _ id: Int)
    
}

protocol sendBackCityIdDelegate {
    func makeRequestWithID(_ id: Int)
}
