//
//  ApiDataSourceGenresTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class ApiDataSourceGenresTests: XCTestCase {
    
    func test_fetchGenres_succeeds_when_networkclient_requests_succeeds_and_response_is_correct() async throws {
        // GIVEN
        let jsonData = """
            {
              "genres": [
                {
                  "id": 28,
                  "name": "Action"
                },
                {
                  "id": 12,
                  "name": "Adventure"
                },
                {
                  "id": 16,
                  "name": "Animation"
                },
                {
                  "id": 35,
                  "name": "Comedy"
                }
            ]
            }
            """
        
        let data = Data(jsonData.utf8)
        let expectedResult = GenresListResponseModel(
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
        
        let sut = ApiDataSourceGenres(
            networkClient: NetworkManagerStub(result: data)
        )
        
        // WHEN
        let capturedResult = try? await sut.fetchGenres()
        
        // THEN
        XCTAssertNotNil(capturedResult)
        XCTAssertEqual(capturedResult, expectedResult)
    }
    
    func test_fetchGenres_fails_when_networkclient_requests_fails() async {
        // GIVEN
        let data: Data? = nil
        let sut = ApiDataSourceGenres(
            networkClient: NetworkManagerStub(result: data)
        )
        
        // WHEN
        let capturedResult = try? await sut.fetchGenres()
        
        // THEN
        XCTAssertNil(capturedResult)
    }
    
    func test_fetchGenres_fails_when_networkclientt_requests_succeeds_and_response_is_not_correct() async throws {
        // GIVEN
        let jsonData = """
            {
              "genres": [
                {
                  "id": "28",
                  "name": "Action"
                },
                {
                  "id": "12",
                  "name": "Adventure"
                },
                {
                  "id": "16",
                  "name": "Animation"
                },
                {
                  "id": "35",
                  "name": "Comedy"
                }
            ]
            }
            """
        
        let data = Data(jsonData.utf8)
        let sut = ApiDataSourceGenres(
            networkClient: NetworkManagerStub(result: data)
        )
        
        // WHEN
        do {
            _ = try await sut.fetchGenres()
            XCTFail("Expected error, got successful response")
            return
        } catch {
            // THEN
            guard let networkError = error as? NetworkManagerStubError
            else {
                XCTFail("Expected network error")
                return
            }
            
            XCTAssertEqual(
                networkError,
                NetworkManagerStubError.parsing
            )
            return
        }
    }
}
