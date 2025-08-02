//
//  NetworkRequestQueryParams.swift
//  NetworkSystem
//
//  Created by Pedro M Moreno on 30/7/25.
//
import Foundation

public enum RequestHeaders {

    public enum Key {
        public static let contentType: String = "Content-Type"
        public static let accept: String = "Accept"
        public static let acceptEncoding: String = "Accept-Encoding"
        public static let connection: String = "Connection"
        public static let cacheControl: String = "Cache-Control"
        public static let authorization: String = "Authorization"
    }

    public enum Value {
        public static let applicationJson: String = "application/json"
        public static let acceptAll: String = "*/*"
        public static let encodings: String = "gzip, deflate, br"
        public static let keepAlive: String = "keep-alive"
        public static let noCache: String = "no-cache"
        public static let bearer: String = "Bearer"
        public static func bearer(_ token: String) -> String {
            return RequestHeaders.Value.bearer
            + " " + token
        }
    }

    public static let standard: [String: String]? = [
        RequestHeaders.Key.contentType: RequestHeaders.Value.applicationJson,
        RequestHeaders.Key.accept: RequestHeaders.Value.acceptAll,
        RequestHeaders.Key.acceptEncoding: RequestHeaders.Value.encodings,
        RequestHeaders.Key.connection: RequestHeaders.Value.keepAlive,
        RequestHeaders.Key.cacheControl: RequestHeaders.Value.noCache
    ]
}
