//
//  ApiDataSourceMovies.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation
import NetworkSystem
import Utils

public protocol ApiDataSourceMoviesProtocol {
    func fetchMovies(
        page: Int,
        sortBy: String,
        genres: [String]
    ) async throws -> MovieListResponseModel
}

public class ApiDataSourceMovies: ApiDataSourceMoviesProtocol {
    private let networkClient: NetworkManager
    
    public init(
        networkClient: NetworkManager
    ) {
        self.networkClient = networkClient
    }
    
    public func fetchMovies(
        page: Int,
        sortBy: String,
        genres: [String]
    )
    async throws -> MovieListResponseModel {
        let request = NetworkRequest(
            domain: DataConstants.URLs.apiBaseURL,
            endpoint: DataConstants.Endpoints.movies,
            method: .get,
            header: [
                RequestHeaders.Key.accept: RequestHeaders.Value.applicationJson,
                RequestHeaders.Key.authorization: RequestHeaders.Value.bearer(
                    DataConstants.apiKey
                )
            ],
            queryParams: [
                NetworkRequestQueryParams(
                    key: "include_adult",
                    value: false
                ),
                NetworkRequestQueryParams(
                    key: "include_video",
                    value: false
                ),
                DataConstants.language,
                NetworkRequestQueryParams(
                    key: "page",
                    value: "\(page)"
                ),
                NetworkRequestQueryParams(
                    key: "sort_by",
                    value: sortBy
                ),
                NetworkRequestQueryParams(
                    key: "with_genres",
                    value: genres
                )
            ],
            dto: NetworkDTO(
                showLog: true,
                cache: false
            )
        )
        
        let response = try await networkClient.sendRequest(
            networkRequest: request,
            responseModel: MovieListResponseModel.self
        )
        
        return response
    }
}
