//
//  Date Extension.swift
//  weather
//
//  Created by Ali Aghajani on 10/4/20.
//

import Foundation

extension Date{
    
    func dayOfTheWeek() -> String? {
            let weekdays = [
                "pazar",
                "pazartesi",
                "salı",
                "çarşamba",
                "perşembe",
                "cuma",
                "cumartesi "
            ]

        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        let components: NSDateComponents = calendar.components(.weekday, from: self) as NSDateComponents
            return weekdays[components.weekday - 1]
        }
}
