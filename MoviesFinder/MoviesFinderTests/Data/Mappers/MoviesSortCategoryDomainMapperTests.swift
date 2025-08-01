//
//  MoviesSortCategoryDomainMapperTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class MoviesSortCategoryDomainMapperTests: XCTestCase {
    func test_map_entities_succesfully() throws {
        // GIVEN
        let mockSortCategoryEntities: [MoviesSortCategoryEntity] = MoviesSortCategoryEntity.allCases
        
        let expectedResults: [String] = [
            "title.asc",
            "title.desc",
            "popularity.asc",
            "popularity.desc",
            "primaryReleaseDate.asc",
            "secondaryReleaseDate.desc"
        ]
        
        let sut = MoviesSortCategoryDomainMapper()
        
        // WHEN
        var capturedResults: [String] = []
        for mockEntity in mockSortCategoryEntities {
            let capturedResult = sut.map(entity: mockEntity)
            capturedResults.append(capturedResult)
        }

        // THEN
        XCTAssertEqual(capturedResults, expectedResults)
    }
}
