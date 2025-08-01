//
//  NetworkManagerStub.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation
import NetworkSystem
@testable import MoviesFinder

public class NetworkManagerStub: NetworkManager {
    let result: Data?
    
    init(
        result: Data?
    ) {
        self.result = result
        super.init()
    }
    
    override public func sendRequest(
        networkRequest: any NetworkRequestProtocol
    ) async throws -> Data {
        guard let result = result
        else {
            throw NetworkManagerStubError.generic
        }
        
        return result
    }
    
    override public func sendRequest<ResponseType>(
        networkRequest: any NetworkRequestProtocol,
        responseModel: ResponseType.Type
    ) async throws -> ResponseType where ResponseType: Decodable {
        guard let result = result
        else {
            throw NetworkManagerStubError.generic
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(responseModel, from: result)
            return decodedResponse
        } catch {
            throw NetworkManagerStubError.parsing
        }
    }
}

enum NetworkManagerStubError: Error {
    case generic
    case parsing
}
