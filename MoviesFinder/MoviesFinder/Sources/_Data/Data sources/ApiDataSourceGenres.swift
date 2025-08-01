//
//  ApiDataSourceGenres.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation
import NetworkSystem

public protocol ApiDataSourceGenresProtocol {
    func fetchGenres() async throws -> GenresListResponseModel
}

public class ApiDataSourceGenres: ApiDataSourceGenresProtocol {
    private let networkClient: NetworkManager
    
    public init(
        networkClient: NetworkManager
    ) {
        self.networkClient = networkClient
    }
    
    public func fetchGenres()
    async throws -> GenresListResponseModel {
        let request = NetworkRequest(
            domain: DataConstants.URLs.apiBaseURL,
            endpoint: DataConstants.Endpoints.genres,
            method: .get,
            header: [
                RequestHeaders.Key.accept: RequestHeaders.Value.applicationJson,
                RequestHeaders.Key.authorization: RequestHeaders.Value.bearer(
                    DataConstants.apiKey
                )
            ],
            queryParams: [
                DataConstants.language
            ],
            dto: NetworkDTO(showLog: true)
        )
        
        let response = try await networkClient.sendRequest(
            networkRequest: request,
            responseModel: GenresListResponseModel.self
        )
        
        return response
    }
}
