//
//  LoggerManager.swift
//  NetworkSystem
//
//  Created by Pedro M Moreno on 30/7/25.
//
import Foundation
import os

public enum LoggerManager {
    
    static public func sendLog(
        category: LoggerCategory = .byDefault,
        subsystem: String? = nil,
        _ message: String
    ) {
        LoggerManager.getLog(
            category: category,
            subsystem: subsystem
        )
        .debug(
            "\(message)"
        )
    }
    
    static public func sendLog(
        category: String,
        subsystem: String? = nil,
        _ message: String
    ) {
        LoggerManager.getLog(
            category: category,
            subsystem: subsystem
        )
        .debug(
            "\(message)"
        )
    }
    
    static private func getLog(
        category: LoggerCategory,
        subsystem: String? = nil
    ) -> Logger {
        return Logger(
            subsystem: subsystem ?? "",
            category: category.rawValue
        )
    }
    
    static private func getLog(
        category: String,
        subsystem: String? = nil
    ) -> Logger {
        return Logger(
            subsystem: subsystem ?? "",
            category: category
        )
    }
}
