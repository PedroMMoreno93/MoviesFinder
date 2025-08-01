//
//  MovieCreditsRepository.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public class MovieCreditsRepository: GetMovieCreditsRepositoryProtocol {
    private let apiDataSourceCredits: ApiDataSourceMovieCreditsProtocol
    private let creditsDomainMapper: MovieCreditsDomainMapper

    public init(
        apiDataSourceCredits: ApiDataSourceMovieCreditsProtocol,
        creditsDomainMapper: MovieCreditsDomainMapper
    ) {
        self.apiDataSourceCredits = apiDataSourceCredits
        self.creditsDomainMapper = creditsDomainMapper
    }
    
    public func getCredits(
        _ movieId: Int
    ) async throws -> MovieCreditsEntity {
        let response = try await apiDataSourceCredits.fetchCredits(
            movieId: movieId
        )
        let entity = creditsDomainMapper.map(responseModel: response)
        return entity
    }
}
