//
//  Date+toString.swift
//  Utils
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public extension Date {
    func toString(
        format: String,
        locale: Locale = Locale.current,
        timeZone: TimeZone = .current
    ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
}
