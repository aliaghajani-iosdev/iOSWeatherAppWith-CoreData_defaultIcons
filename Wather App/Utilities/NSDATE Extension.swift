//
//  NSDATE Extension.swift
//  Wather App
//
//  Created by Ali Aghajani on 10/6/20.
//

import Foundation


extension Formatter {
    static let weekdayName: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "cccc"
        return formatter
    }()
    static let customDate: DateFormatter = {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-M-d"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
extension Date {
    var weekdayName: String { Formatter.weekdayName.string(from: self) }
}
