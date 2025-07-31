//
//  MoviesRepository.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation

public class MoviesRepository: GetMoviesListRepositoryProtocol {
    private let apiDataSourceMovies: ApiDataSourceMoviesProtocol
    private let moviesDomainMapper: MoviesDomainMapper
    private let moviesSortCategoryDomainMapper: MoviesSortCategoryDomainMapper
    
    public init(
        apiDataSourceMovies: ApiDataSourceMoviesProtocol,
        moviesDomainMapper: MoviesDomainMapper,
        moviesSortCategoryDomainMapper: MoviesSortCategoryDomainMapper
    ) {
        self.apiDataSourceMovies = apiDataSourceMovies
        self.moviesDomainMapper = moviesDomainMapper
        self.moviesSortCategoryDomainMapper = moviesSortCategoryDomainMapper
    }

    
    public func getMovies(
        page: Int,
        sortBy: MoviesSortCategoryEntity,
        genres: [GenreEntity]
    ) async throws -> [MoviesListItemEntity] {
        let response = try await apiDataSourceMovies.fetchMovies(
            page: page,
            sortBy: moviesSortCategoryDomainMapper.map(
                entity: sortBy
            ),
            genres: moviesDomainMapper.mapGenresIds(genres)
        )
        let entities = moviesDomainMapper.map(responseModel: response)
        return entities
    }
}
