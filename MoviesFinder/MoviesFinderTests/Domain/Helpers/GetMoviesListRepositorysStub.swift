//
//  GetMoviesListRepositorysStub.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation
@testable import MoviesFinder

class GetMoviesListRepositorysStub: GetMoviesListRepositoryProtocol {
    var result: [MoviesListItemEntity]?
   
    init(result: [MoviesListItemEntity]?) {
        self.result = result
    }
    
    func getMovies(
        page: Int,
        sortBy: MoviesSortCategoryEntity,
        genres: [GenreEntity]
    ) async throws -> [MoviesListItemEntity] {
        guard let result = result
        else {
            throw GetMoviesListRepositorysStubError()
        }
        return result
    }
}

struct GetMoviesListRepositorysStubError: Error {
    
}
