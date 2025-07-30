//
//  NetworkRequest.swift
//  NetworkSystem
//
//  Created by Pedro M Moreno on 30/7/25.
//
import Foundation

public struct NetworkRequest: NetworkRequestProtocol {
    public var domain: String
    public var endpoint: String
    public var method: RequestMethod
    public var header: [String: String]?
    public var body: Data?
    public var queryParams: [NetworkRequestQueryParams]?
    public var dto: NetworkDTO
    
    public init(
        domain: String,
        endpoint: String,
        method: RequestMethod,
        header: [String: String]? = nil,
        body: Data? = nil,
        queryParams: [NetworkRequestQueryParams]? = nil,
        dto: NetworkDTO = NetworkDTO()
    ) {
        self.domain = domain
        self.endpoint = endpoint
        self.method = method
        self.header = header
        self.body = body
        self.queryParams = queryParams
        self.dto = dto
    }
    
    public func retry() -> NetworkRequest {
        NetworkRequest(
            domain: self.domain,
            endpoint: self.endpoint,
            method: self.method,
            header: self.header,
            body: self.body,
            queryParams: self.queryParams,
            dto: NetworkDTO(
                timeout: self.dto.timeout,
                retry: self.dto.retry - 1,
                showLog: self.dto.showLog
            )
        )
    }
    
    /// Constructor que permite crear la "request" a partir de la información indicada por el protocolo "NetworkRequestProtocol"
    /// - Returns: la request a realizar.
    public func build() throws -> URLRequest {
        // 1. Se crea la URL
        if let url = URL(string: "\(self.domain)\(self.endpoint)") {
            // 2. Se añaden los query params, si existen
            let urlWithParams = addQueryParamsIfNeeded(
                toURL: url,
                queryParams: self.queryParams
            )
            // 3. Se crea la request con el timeout
            var request = URLRequest(
                url: urlWithParams,
                timeoutInterval: self.dto.timeout
            )
            
            // 4. Se añade el "verbo" del método de la petición
            request.httpMethod = method.rawValue
            
            // 5. Se añaden el body, si existe
            let contentLenght = self.addHttpBodyIfNeeded(&request)
            
            // 6. Se añaden los headers, si existen
            self.addHeadersIfNeeded(
                &request,
                contentLength: contentLenght
            )
            
            return request
        }
        
        throw NetworkResponseError(code: .invalidURL, data: nil)
    }
    
    public func getURL() -> URL? {
        URL(string: "\(self.domain)\(self.endpoint)")
    }
    
    public func toString() -> String {
        if !self.dto.showLog {
            return ""
        }
        return
"""
domain: \(self.domain)
endpoint: \(self.endpoint)
method: \(self.method.rawValue)
header: \(self.header ?? [:])
body: \(self.body?.jsonString() ?? "No hay body")
"""
    }
    
    private func addQueryParamsIfNeeded(
        toURL url: URL,
        queryParams: [NetworkRequestQueryParams]?
    ) -> URL {
        guard let queryParams = queryParams,
              var urlComponents = URLComponents(
                url: url,
                resolvingAgainstBaseURL: false
              )
        else {
            return url
        }
        var queryItems: [URLQueryItem] = []
        for param in queryParams {
            if param.value is [Any] {
                let values = param.value as? [Any]
                if let safeValues = values {
                    for value in safeValues {
                        let item = URLQueryItem(name: param.key, value: "\(value)")
                        queryItems.append(item)
                    }
                }
            } else {
                let item = URLQueryItem(name: param.key, value: "\(param.value)")
                queryItems.append(item)
            }
        }
        
        urlComponents.queryItems = queryItems
        
        guard let urlString = urlComponents.url?.absoluteString.replacingOccurrences(of: "%2520", with: "%20"),
              let updatedURL = URL(string: urlString)
        else {
            return url
        }
        
        return updatedURL
    }
    
    private func addHttpBodyIfNeeded(_ request: inout URLRequest) -> Int {
        if let body = self.body {
            request.httpBody = body
            return body.count
        }
        return 0
    }
    
    /// De existir, se añaden los headers de la petición
    /// - Parameters:
    ///   - request: request de la cual se obtienen los headers
    ///   - contentLength: contentLength, para añadir la clave "Content-Length" en el caso de que se haya añadido un "body".
    private func addHeadersIfNeeded(
        _ request: inout URLRequest,
        contentLength: Int = 0
    ) {
        
        if let header {
            request.allHTTPHeaderFields = header
        }
        
        //        request.setValue("Cache-Control", forHTTPHeaderField: "max-age=60")
        request.allHTTPHeaderFields?["Cache-Control"] = "max-age=10"
        
        if contentLength > 0 {
            request.allHTTPHeaderFields?["Content-Length"] = "\(contentLength)"
        }
    }
}
