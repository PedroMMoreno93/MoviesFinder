//
//  LanguageUtils.swift
//  Utils
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation

public enum LanguageUtils {
    public static let defaultLanguageCode: String = "en"
    
    public static func getLanguageCode() -> String {
        if #available(macOS 13, *) {
            return Locale.current.language.languageCode?.identifier ?? LanguageUtils.defaultLanguageCode
        } else {
            return Locale.current.languageCode ?? LanguageUtils.defaultLanguageCode
        }
    }
}
