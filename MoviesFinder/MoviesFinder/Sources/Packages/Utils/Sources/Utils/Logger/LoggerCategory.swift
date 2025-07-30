//
//  LoggerCategory.swift
//  Utils
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation

public enum LoggerCategory: String {
    case byDefault = "Default"
    case request = "Request"
    case database = "Database"
    case uiInteraction = "UI"
    case response = "Response"
    case responseError = "ResponseError"
}
