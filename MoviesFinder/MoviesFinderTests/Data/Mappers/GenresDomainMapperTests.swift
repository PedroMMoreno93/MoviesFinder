//
//  GenresDomainMapperTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class GenresDomainMapperTests: XCTestCase {
    func test_map_returns_valid_result_for_valid_input() throws {
        // GIVEN
        let mockResponseModel = GenresListResponseModel(
            genres: [
                GenresListItemResponseModel(
                    id: 28,
                    name: "Action"
                ),
                GenresListItemResponseModel(
                    id: 12,
                    name: "Adventure"
                ),
                GenresListItemResponseModel(
                    id: 16,
                    name: "Animation"
                ),
                GenresListItemResponseModel(
                    id: 35,
                    name: "Comedy"
                )
            ]
        )
        
        let expectedResult = [
            GenreEntity(id: 28, name: "Action"),
            GenreEntity(id: 12, name: "Adventure"),
            GenreEntity(id: 16, name: "Animation"),
            GenreEntity(id: 35, name: "Comedy")
        ]
        let sut = GenresDomainMapper()
        
        // WHEN
        let capturedResult = sut.map(responseModel: mockResponseModel)
     
        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
    
    func test_map_filters_invalid_items() throws {
        // GIVEN
        let mockResponseModel = GenresListResponseModel(
            genres: [
                GenresListItemResponseModel(
                    id: nil,
                    name: "Action"
                ),
                GenresListItemResponseModel(
                    id: 12,
                    name: nil
                ),
                GenresListItemResponseModel(
                    id: 16,
                    name: "Animation"
                ),
                GenresListItemResponseModel(
                    id: 35,
                    name: "Comedy"
                )
            ]
        )
        
        let expectedResult = [
            GenreEntity(id: 16, name: "Animation"),
            GenreEntity(id: 35, name: "Comedy")
        ]
        let sut = GenresDomainMapper()
        
        // WHEN
        let capturedResult = sut.map(responseModel: mockResponseModel)
     
        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
    
    func test_map_genresids_returns_valid_result_for_valid_input() throws {
        // GIVEN
        let mockGenres = [
            GenreEntity(id: 16, name: "Animation"),
            GenreEntity(id: 35, name: "Comedy")
        ]
        
        let expectedResult = [
            "16",
            "35"
        ]

        let sut = GenresDomainMapper()
        
        // WHEN
        let capturedResult = sut.mapGenresIds(mockGenres)
     
        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
}
