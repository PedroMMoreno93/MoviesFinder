//
//  ApiDataSourceMovieDetails.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import NetworkSystem
import Utils

public protocol ApiDataSourceMovieDetailsProtocol {
    func fetcDetails(
        movieId: Int
    ) async throws -> MovieDetailsResponseModel
}

public class ApiDataSourceMovieDetails: ApiDataSourceMovieDetailsProtocol {
    private let networkClient: NetworkManager
    
    public init(
        networkClient: NetworkManager
    ) {
        self.networkClient = networkClient
    }
    
    public func fetcDetails(
        movieId: Int
    ) async throws -> MovieDetailsResponseModel {
        let request = NetworkRequest(
            domain: DataConstants.URLs.apiBaseURL,
            endpoint: DataConstants.Endpoints.movieDetails(movieId),
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
            responseModel: MovieDetailsResponseModel.self
        )
        
        return response

    }
}
