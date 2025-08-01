//
//  GetGenresRepositoryStub.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation
@testable import MoviesFinder

class GetGenresRepositoryStub: GetGenresListRepositoryProtocol {
    var result: [GenreEntity]?
   
    init(result: [GenreEntity]?) {
        self.result = result
    }
    
    func getGenres() async throws -> [GenreEntity] {
        guard let result = result
        else {
            throw GetGenresStubRepositoryError()
        }
        return result
    }
}

struct GetGenresStubRepositoryError: Error {
    
}
