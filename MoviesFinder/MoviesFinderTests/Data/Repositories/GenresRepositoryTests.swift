//
//  GenresRepositoryTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class GenresRepositoryTests: XCTestCase {

    func test_getgenres_returns_success() async throws {
        // GIVEN
       let result = GenresListResponseModel(
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
        let expectedResult: [GenreEntity] = [
            GenreEntity(id: 28, name: "Action"),
            GenreEntity(id: 12, name: "Adventure"),
            GenreEntity(id: 16, name: "Animation"),
            GenreEntity(id: 35, name: "Comedy")
        ]
        
        let apiDataSource = ApiDataSourceGenresStub(
            result: result
        )
        let sut = GenresRepository(
            apiDataSourceGenres: apiDataSource,
            genresDomainMapper: GenresDomainMapper()
        )
        
        // WHEN
        let capturedResult = try? await sut.getGenres()
        
        // THEN
        XCTAssertNotNil(capturedResult)
        XCTAssertEqual(capturedResult, expectedResult)
    }
    
    func test_getgenres_returns_fails() async throws {
        // GIVEN
        let result: GenresListResponseModel? = nil
       
        let apiDataSource = ApiDataSourceGenresStub(
            result: result
        )
        let sut = GenresRepository(
            apiDataSourceGenres: apiDataSource,
            genresDomainMapper: GenresDomainMapper()
        )
        
        // WHEN
        do {
            _ = try await sut.getGenres()
            XCTFail("Expected error, got successful response")
            return
        } catch {
            // THEN
            guard let apiError = error as? ApiDataSourceGenresStubError
            else {
                XCTFail("Expected api error")
                return
            }
            
            XCTAssertEqual(
                apiError.message,
                "Error"
            )
            return
        }
    }
}
