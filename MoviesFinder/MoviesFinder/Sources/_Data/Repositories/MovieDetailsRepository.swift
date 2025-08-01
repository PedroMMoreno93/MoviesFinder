//
//  MovieDetailsRepository.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public class MovieDetailsRepository: GetMovieDetailsRepositoryProtocol {
    private let apiDataSourceDetails: ApiDataSourceMovieDetailsProtocol
    private let detailsDomainMapper: MovieDetailsDomainMapper

    public init(
        apiDataSourceDetails: ApiDataSourceMovieDetailsProtocol,
        detailsDomainMapper: MovieDetailsDomainMapper
    ) {
        self.apiDataSourceDetails = apiDataSourceDetails
        self.detailsDomainMapper = detailsDomainMapper
    }
    
    public func getDetails(
        _ movieId: Int
    ) async throws -> MovieDetailsEntity {
        let response = try await apiDataSourceDetails.fetcDetails(
            movieId: movieId
        )
        let entity = detailsDomainMapper.map(responseModel: response)
        return entity
    }
}
