//
//  GetGenresListTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class GetGenresListTests: XCTestCase {
    
    func test_execute_sucesfully_returns_sorted_array_when_repository_returns_nonEmpty_array() async throws {
        // GIVEN
        let mockArray = [
            GenreEntity(id: 16, name: "Comedy"),
            GenreEntity(id: 28, name: "Action"),
            GenreEntity(id: 52, name: "Thriller")
        ]
        let stub = GetGenresRepositoryStub(result: mockArray)
        let sut = GetGenresList(repository: stub)
        
        // WHEN
        let capturedResult = try? await sut.execute()

        // THEN
        XCTAssertNotNil(capturedResult)
        XCTAssertEqual(capturedResult?[0], mockArray[1])
        XCTAssertEqual(capturedResult?[1], mockArray[0])
        XCTAssertEqual(capturedResult?[2], mockArray[2])
    }
    
    func test_execute_sucesfully_returns_sorted_array_when_repository_returns_nonEmpty_sorted_array() async {
        // GIVEN
        let mockArray = [
            GenreEntity(id: 28, name: "Action"),
            GenreEntity(id: 16, name: "Comedy"),
            GenreEntity(id: 52, name: "Thriller")
        ]
        let stub = GetGenresRepositoryStub(result: mockArray)
        let sut = GetGenresList(repository: stub)
        
        // WHEN
        let capturedResult = try? await sut.execute()

        // THEN
        XCTAssertNotNil(capturedResult)
        XCTAssertEqual(capturedResult, mockArray)
    }
    
    func test_execute_sucesfully_returns_anEmpty_array_when_repository_returns_anEmpty_array() async {
        // GIVEN
        let mockArray: [GenreEntity] = []
        let stub = GetGenresRepositoryStub(result: mockArray)
        let sut = GetGenresList(repository: stub)
        
        // WHEN
        let capturedResult = try? await sut.execute()

        // THEN
        XCTAssertNotNil(capturedResult)
        XCTAssertEqual(capturedResult, mockArray)
    }
    
    func test_execute_returns_error_when_repository_returns_error() async {
        // GIVEN
        let mockArray: [GenreEntity]? = nil
        let stub = GetGenresRepositoryStub(result: mockArray)
        let sut = GetGenresList(repository: stub)
        
        // WHEN
        let capturedResult = try? await sut.execute()

        // THEN
        XCTAssertNil(capturedResult)
        XCTAssertEqual(capturedResult, mockArray)
    }
}
