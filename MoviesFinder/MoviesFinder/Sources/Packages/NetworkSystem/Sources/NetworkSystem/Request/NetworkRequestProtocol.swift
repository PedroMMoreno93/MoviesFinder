//
//  NetworkRequestProtocol.swift
//  NetworkSystem
//
//  Created by Pedro M Moreno on 30/7/25.
//
import Foundation

public protocol NetworkRequestProtocol {
    var domain: String { get }
    var endpoint: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: Data? { get }
    var queryParams: [NetworkRequestQueryParams]? { get }
    var dto: NetworkDTO { get }
    func toString() -> String
    func build() throws -> URLRequest
    func retry() -> Self
}
