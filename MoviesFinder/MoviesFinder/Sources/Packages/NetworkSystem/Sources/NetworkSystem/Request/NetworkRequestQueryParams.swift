//
//  NetworkRequestQueryParams.swift
//  NetworkSystem
//
//  Created by Pedro M Moreno on 30/7/25.
//
import Foundation

public struct NetworkRequestQueryParams {
    public let key: String
    public let value: Any

    public init(
        key: String,
        value: Any
    ) {
        self.key = key
        self.value = value
    }
}
