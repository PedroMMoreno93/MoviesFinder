//
//  GetMoviesListRepositoryProtocol.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation

public protocol GetMoviesListRepositoryProtocol {
    func getMovies(
        page: Int,
        sortBy: MoviesSortCategoryEntity,
        genres: [GenreEntity]
    ) async throws -> [MoviesListItemEntity]
}
