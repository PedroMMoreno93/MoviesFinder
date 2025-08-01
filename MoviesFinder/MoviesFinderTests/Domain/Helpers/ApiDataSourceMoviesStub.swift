//
//  ApiDataSourceMoviesStub.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation
@testable import MoviesFinder

class ApiDataSourceMoviesStub: ApiDataSourceMoviesProtocol {
    let result: MovieListResponseModel?
    
    init(result: MovieListResponseModel?) {
        self.result = result
    }
    
    public func fetchMovies(
        page: Int,
        sortBy: String,
        genres: [String]
    ) async throws -> MovieListResponseModel {
        guard let result = result
        else {
            throw ApiDataSourceMoviesStubError(message: "Error")
        }
        
        return result
    }
}

struct ApiDataSourceMoviesStubError: Error {
    let message: String
}
