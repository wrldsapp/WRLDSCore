//
//  DatePicker+Helpers.swift
//  WRLDS
//
//  Created by Garrett Jester on 9/1/20.
//  Copyright © 2020 WRLDS. All rights reserved.
//

import UIKit

public extension UIDatePicker {
    
    func setMinAge(age: Int) {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = 0 - age
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year = -150
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        self.minimumDate = minDate
        self.maximumDate = maxDate
    }
}

public extension DateFormatter {
    
    func format(date: Date, withFormat format: DateFormat, locale: Locale?) -> String {
        self.locale = locale ?? Locale.current
        self.dateFormat = format.rawValue
        return self.string(from: date)
    }
}

enum DateFormat: String {
    case ISO8601 = "yyyy-MM-dd"
    case readable = "MMM dd, yyyy"
}
