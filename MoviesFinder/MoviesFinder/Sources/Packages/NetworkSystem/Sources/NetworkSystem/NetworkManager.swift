//
//  LoggerManager.swift
//  NetworkSystem
//
//  Created by Pedro M Moreno on 30/7/25.
//

import CryptoKit
import Foundation
import Utils

final class NetworkManager {
    
    var urlProtocol: URLProtocol.Type?
    private var request: NetworkRequestProtocol?
    private var cacheDuration: TimeInterval // En segundos
    private let userInfoDateKey: String = "cacheDate"
    
    func session(timeout: TimeInterval) -> URLSession {
        if let urlProtocol = urlProtocol {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [urlProtocol]
            return URLSession(configuration: configuration)
        } else {
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = timeout
            configuration.urlCache = URLCache.shared
            
            return URLSession(
                configuration: configuration,
                delegate: nil,
                delegateQueue: nil
            )
        }
    }
    
    /// Inicializador para gestionar las peticiones
    /// - Parameters:
    ///   - urlProtocol: Indica si la gestión es la normal (nil) o a través de una implementación local
    ///   - memoryCapacigyInMB: Tamaño de la caché de memoria, en mega bytes. 50 MB por defecto
    ///   - diskCapacigyInMB: Tamaño de la caché de disco, en mega bytes. 100 MB por defecto
    ///   - cacheDuration: Duración, en segundos, de la caché. 86400 segundos (un día) por defecto
    public init(
        urlProtocol: URLProtocol.Type? = nil,
        memoryCapacigyInMB: Int = 50,
        diskCapacigyInMB: Int = 100,
        cacheDuration: TimeInterval = 86400
    ) {
        self.urlProtocol = urlProtocol
        let cache = URLCache(
            memoryCapacity: memoryCapacigyInMB * 1024 * 1024,
            diskCapacity: diskCapacigyInMB * 1024 * 1024
        )
        URLCache.shared = cache
        self.cacheDuration = cacheDuration
    }
    
    public func sendRequest(
        networkRequest: NetworkRequestProtocol
    ) async throws -> Data {
        self.request = networkRequest
        self.log(category: .request, message: networkRequest.toString())
        let data = try await handleRequest(request: networkRequest.build())
        return data
    }
    
    public func sendRequest<ResponseType: Decodable>(
        networkRequest: NetworkRequestProtocol,
        responseModel: ResponseType.Type
    ) async throws -> ResponseType {
        self.request = networkRequest
        self.log(category: .request, message: networkRequest.toString())
        let data = try await handleRequest(request: networkRequest.build())
        
        do {
            let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
            return decodedResponse
        } catch {
            let error = NetworkResponseError(code: .jsonDecode, data: data)
            self.logError(error)
            throw error
        }
    }

    func handleRequest(
        request: URLRequest
    ) async throws -> Data {
        
        if await NetworkMonitor.shared.isConnected {
            return try await self.handleConnectedRequest(request)
        } else {
            return try await self.handleNoConnection()
        }
    }
    
    private func handleConnectedRequest(
        _ request: URLRequest
    ) async throws -> Data {
        do {
            let (data, response) = try await session(
                timeout: request.timeoutInterval
            ).data(
                for: request,
                delegate: nil
            )
            
            guard let response = response as? HTTPURLResponse
            else {
                let error = NetworkResponseError(code: .noResponse, data: nil)
                self.logError(error)
                throw error
            }
            
            // Tries to create a known http code
            if let responseStatus = ResponseHTTPCode(rawValue: response.statusCode) {
                return try await self.handleHTTPCodeResponse(
                    request,
                    data: data,
                    response: response,
                    responseStatus
                )
            } else {
                return try await self.handleUnkownCodeResponse()
            }
        } catch let error as URLError {
            throw self.handleURLError(error)
        }
    }
    
    private func handleUnkownCodeResponse() async throws -> Data {
        // Retries the request
        if self.request?.dto.retry ?? 0 > 0,
           let newRequest = self.request?.retry() {
            self.request = newRequest
            return try await handleRequest(request: newRequest.build())
        } else {
            // if http code is unknown
            let error = NetworkResponseError(code: .unknown, data: nil)
            self.logError(error)
            throw error
        }
    }
    
    private func handleHTTPCodeResponse(
        _ request: URLRequest,
        data: Data,
        response: HTTPURLResponse,
        _ responseStatus: ResponseHTTPCode
    ) async throws -> Data {
        // If its 200
        if responseStatus.isSuccess {
            if self.request?.dto.showLog ?? false {
                self.log(category: .response, message: data.jsonString())
            }
            
            // Cachea la respuesta y el data, asociada a una request
            if self.request?.dto.cache ?? false {
                URLCache.shared.storeCachedResponse(
                    CachedURLResponse(
                        response: response,
                        data: data,
                        userInfo: [self.userInfoDateKey: Date()],
                        storagePolicy: URLCache.StoragePolicy.allowed
                    ),
                    for: request
                )
            }
            
            return data
        }
        
        if self.request?.dto.retry ?? 0 > 0,
           let newRequest = self.request?.retry() {
            self.request = newRequest
            return try await handleRequest(request: newRequest.build())
        } else {
         
            // Any error code other than 200
            let error = NetworkResponseError(code: responseStatus, data: data)
            self.logError(error)
            throw error
        }
    }
    
    private func handleURLError(
        _ error: URLError
    ) -> Error {
        switch error.code {
        case .notConnectedToInternet:
            let error = NetworkResponseError(code: .noInternetConnection, data: nil)
            self.logError(error)
            return error
        case .timedOut:
            let error = NetworkResponseError(code: .requestTimeout, data: nil)
            self.logError(error)

            return error
        default:
            let error = NetworkResponseError(code: .unknown, data: nil)
            self.logError(error)

            return error
        }
    }
    
    private func handleNoConnection() async throws -> Data {
        // Tries to obtain the info from cache
        if let request = try? self.request?.build(),
           let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let userInfo = cachedResponse.userInfo,
           let date = userInfo[self.userInfoDateKey] as? Date {
            
            // If it's within the time of cache time, data is returned...
            if (Date().timeIntervalSince1970 - date.timeIntervalSince1970) < self.cacheDuration {
                return cachedResponse.data
            }
            
            // ... if not, cache is removed and an exception is returned
            URLCache.shared.removeCachedResponse(for: request)
            let error = NetworkResponseError(code: .noInternetConnection, data: nil)
            self.logError(error)
            throw error
        }
        
        let error = NetworkResponseError(code: .noInternetConnection, data: nil)
        self.logError(error)
        throw error
    }
    
    private func logError(
        _ error: NetworkResponseError
    ) {
        self.log(category: .responseError, message: error.toString())
    }
    
    private func log(
        category: LoggerCategory,
        message: String
    ) {
        LoggerManager.sendLog(
            category: category,
            subsystem: "Network",
            message
        )
    }
}
