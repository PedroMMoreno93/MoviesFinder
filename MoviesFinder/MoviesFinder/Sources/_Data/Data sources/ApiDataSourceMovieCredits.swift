//
//  ApiDataSourceMovieCredits.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import NetworkSystem
import Utils

public protocol ApiDataSourceMovieCreditsProtocol {
    func fetchCredits(
        movieId: Int
    ) async throws -> MovieCreditsResponseModel
}

public class ApiDataSourceMovieCredits: ApiDataSourceMovieCreditsProtocol {
    private let networkClient: NetworkManager
    
    public init(
        networkClient: NetworkManager
    ) {
        self.networkClient = networkClient
    }
    
    public func fetchCredits(
        movieId: Int
    ) async throws -> MovieCreditsResponseModel {
        let request = NetworkRequest(
            domain: DataConstants.URLs.apiBaseURL,
            endpoint: DataConstants.Endpoints.movieCredits(movieId),
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
            responseModel: MovieCreditsResponseModel.self
        )
        
        return response

    }
}
