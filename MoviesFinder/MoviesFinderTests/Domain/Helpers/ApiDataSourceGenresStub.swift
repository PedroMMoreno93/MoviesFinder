//
//  ApiDataSourceGenresStub.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation
@testable import MoviesFinder

class ApiDataSourceGenresStub: ApiDataSourceGenresProtocol {
    let result: GenresListResponseModel?
    
    init(result: GenresListResponseModel?) {
        self.result = result
    }
    
    func fetchGenres() async throws -> GenresListResponseModel {
        guard let result = result
        else {
            throw ApiDataSourceGenresStubError(message: "Error")
        }
        
        return result
    }
}

struct ApiDataSourceGenresStubError: Error {
    let message: String
}
