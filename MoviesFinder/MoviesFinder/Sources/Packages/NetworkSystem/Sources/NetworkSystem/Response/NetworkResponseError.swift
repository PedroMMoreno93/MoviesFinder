//
//  NetworkResponseError.swift
//  NetworkSystem
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation

public struct NetworkResponseError: Error {
    public let code: ResponseHTTPCode
    public let data: Data?

    public func toString() -> String {
"""
❌❌❌
ErrorCode: \(code)[\(code.rawValue)] - \(code.description)
Data: \(data?.jsonString() ?? "")
"""
    }
}
