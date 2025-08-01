//
//  String+toDate.swift
//  Utils
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public extension String {
    func toDate(
        format: String,
        locale: Locale = Locale.current
    ) -> Date? {
           let formatter = DateFormatter()
           formatter.dateFormat = format
           formatter.locale = locale
           formatter.timeZone = TimeZone(secondsFromGMT: 0)
           return formatter.date(from: self)
       }
}
