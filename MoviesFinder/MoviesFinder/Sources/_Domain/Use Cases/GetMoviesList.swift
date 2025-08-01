//
//  GetMoviesList.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation

public protocol GetMoviesListUseCase {
    func execute(
        page: Int,
        sortBy: MoviesSortCategoryEntity,
        genres: [GenreEntity]
    ) async throws -> [MoviesListItemEntity]
}

public class GetMoviesList: GetMoviesListUseCase {
    private let repository: GetMoviesListRepositoryProtocol
    
    public init(repository: GetMoviesListRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(
        page: Int,
        sortBy: MoviesSortCategoryEntity,
        genres: [GenreEntity]
    ) async throws -> [MoviesListItemEntity] {
        do {
            let response = try await repository.getMovies(
                page: page,
                sortBy: sortBy,
                genres: genres
            )
            return response
        } catch {
            throw error
        }
    }
}
