//
//  Data+jsonString.swift
//  NetworkSystem
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation

extension Data {
    func jsonString() -> String {
        guard let jsonObject = try? JSONSerialization.jsonObject(
            with: self,
            options: []
        ), let data = try? JSONSerialization.data(
            withJSONObject: jsonObject,
            options: [
                .prettyPrinted,
                .sortedKeys
            ]
        ), let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else {
            return String(data: self, encoding: .utf8) ?? "Data is not encodable"
        }
        
        return String(json)
    }
}
