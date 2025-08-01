//
//  GetMoviesListTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class GetMoviesListTests: XCTestCase {
    func test_execute_sucesfully_returns_sorted_array_when_repository_returns_nonEmpty_sorted_array() async {
        // GIVEN
        let mockArray = [
            MoviesListItemEntity(
                adult: false,
                backdropPath: nil,
                genreIDS: [1],
                id: 1,
                originalLanguage: "en",
                originalTitle: "",
                overview: "Mock overview 1",
                popularity: nil,
                posterPath: nil,
                releaseDate: nil,
                title: "Mock title 1",
                video: nil,
                voteAverage: nil,
                voteCount: nil
            ),
            MoviesListItemEntity(
                adult: false,
                backdropPath: nil,
                genreIDS: [2],
                id: 2,
                originalLanguage: "es",
                originalTitle: "",
                overview: "Mock overview 2",
                popularity: nil,
                posterPath: nil,
                releaseDate: nil,
                title: "Mock title 2",
                video: nil,
                voteAverage: nil,
                voteCount: nil
            )
        ]
        let stub = GetMoviesListRepositorysStub(result: mockArray)
        let sut = GetMoviesList(repository: stub)
        
        // WHEN
        let capturedResult = try? await sut.execute(
            page: 1,
            sortBy: .popularityAscending,
            genres: []
        )

        // THEN
        XCTAssertNotNil(capturedResult)
        XCTAssertEqual(capturedResult, mockArray)
    }
    
    func test_execute_sucesfully_returns_anEmpty_array_when_repository_returns_anEmpty_array() async {
        // GIVEN
        let mockArray: [MoviesListItemEntity] = []
        let stub = GetMoviesListRepositorysStub(result: mockArray)
        let sut = GetMoviesList(repository: stub)
        
        // WHEN
        let capturedResult = try? await sut.execute(
            page: 1,
            sortBy: .popularityAscending,
            genres: []
        )

        // THEN
        XCTAssertNotNil(capturedResult)
        XCTAssertEqual(capturedResult, mockArray)
    }
    
    func test_execute_returns_error_when_repository_returns_error() async {
        // GIVEN
        let mockArray: [MoviesListItemEntity]? = nil
        let stub = GetMoviesListRepositorysStub(result: mockArray)
        let sut = GetMoviesList(repository: stub)
        
        // WHEN
        let capturedResult = try? await sut.execute(
            page: 1,
            sortBy: .popularityAscending,
            genres: []
        )

        // THEN
        XCTAssertNil(capturedResult)
        XCTAssertEqual(capturedResult, mockArray)
    }
}
