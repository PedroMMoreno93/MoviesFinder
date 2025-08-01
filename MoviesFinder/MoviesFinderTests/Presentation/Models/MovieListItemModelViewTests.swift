//
//  MovieListItemModelViewTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class MovieListItemModelViewTests: XCTestCase {
    func test_successful_init_from_entity_and_valid_genres_ids() throws {
        // GIVEN
        let mockListItemEntity = MoviesListItemEntity(
            adult: false,
            backdropPath: nil,
            genreIDS: [
                28,
                12,
                16
            ],
            id: 1071585,
            originalLanguage: "en",
            originalTitle: "M3GAN 2.0",
            overview: "mock overview",
            popularity: 0,
            posterPath: nil,
            releaseDate: "2025-06-25",
            title: "M3GAN 2.0",
            video: false,
            voteAverage: 0,
            voteCount: 0
        )

        let mockGenresEntities = [
            GenreEntity(id: 28, name: "Action"),
            GenreEntity(id: 12, name: "Adventure"),
            GenreEntity(id: 16, name: "Animation")
        ]
        let sut = MovieListItemModelView(
            from: mockListItemEntity,
            genreEntities: mockGenresEntities
        )
        
        let expectedTitleResult = "M3GAN 2.0"
        let expectedBadgesResult: [String] = [
            "Action",
            "Adventure",
            "Animation"
        ]

        // WHEN
        let capturedTitleResult = sut.title
        let capturedBadgesResult = sut.badges

        // THEN
        XCTAssertEqual(capturedTitleResult, expectedTitleResult)
        XCTAssertEqual(capturedBadgesResult, expectedBadgesResult)
    }
    
    func test_successful_init_from_entity_and_invalid_genres_ids() throws {
        // GIVEN
        let mockListItemEntity = MoviesListItemEntity(
            adult: false,
            backdropPath: nil,
            genreIDS: [
                14,
                49,
                91
            ],
            id: 1071585,
            originalLanguage: "en",
            originalTitle: "M3GAN 2.0",
            overview: "mock overview",
            popularity: 0,
            posterPath: nil,
            releaseDate: "2025-06-25",
            title: "M3GAN 2.0",
            video: false,
            voteAverage: 0,
            voteCount: 0
        )

        let mockGenresEntities = [
            GenreEntity(id: 28, name: "Action"),
            GenreEntity(id: 12, name: "Adventure"),
            GenreEntity(id: 16, name: "Animation")
        ]
        let sut = MovieListItemModelView(
            from: mockListItemEntity,
            genreEntities: mockGenresEntities
        )
        
        let expectedTitleResult = "M3GAN 2.0"
        let expectedBadgesResult: [String] = []

        // WHEN
        let capturedTitleResult = sut.title
        let capturedBadgesResult = sut.badges

        // THEN
        XCTAssertEqual(capturedTitleResult, expectedTitleResult)
        XCTAssertEqual(capturedBadgesResult, expectedBadgesResult)
    }
    
    func test_successful_init_from_entity_and_empty_genres_ids() throws {
        // GIVEN
        let mockListItemEntity = MoviesListItemEntity(
            adult: false,
            backdropPath: nil,
            genreIDS: [],
            id: 1071585,
            originalLanguage: "en",
            originalTitle: "M3GAN 2.0",
            overview: "mock overview",
            popularity: 0,
            posterPath: nil,
            releaseDate: "2025-06-25",
            title: "M3GAN 2.0",
            video: false,
            voteAverage: 0,
            voteCount: 0
        )

        let mockGenresEntities = [
            GenreEntity(id: 28, name: "Action"),
            GenreEntity(id: 12, name: "Adventure"),
            GenreEntity(id: 16, name: "Animation")
        ]
        let sut = MovieListItemModelView(
            from: mockListItemEntity,
            genreEntities: mockGenresEntities
        )
        
        let expectedTitleResult = "M3GAN 2.0"
        let expectedBadgesResult: [String] = []

        // WHEN
        let capturedTitleResult = sut.title
        let capturedBadgesResult = sut.badges

        // THEN
        XCTAssertEqual(capturedTitleResult, expectedTitleResult)
        XCTAssertEqual(capturedBadgesResult, expectedBadgesResult)
    }
    
    func test_description_forms_correctly() throws {
        // GIVEN
        let mockOverview = "MockOverview"
        
        let sut = MovieListItemModelView(
            title: "",
            overview: mockOverview,
            language: "",
            backdropPath: "",
            genres: []
        )
        let expectedResult = "MockOverview"
        
        // WHEN
        let capturedResult = sut.description
        
        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
    
    func test_badges_forms_correctly_when_genres_have_valid_values() throws {
        // GIVEN
        let mockGenres: [GenreEntity] = [
            GenreEntity(id: 1, name: "mock name 1"),
            GenreEntity(id: 2, name: "mock name 2")
        ]
        
        let sut = MovieListItemModelView(
            title: "",
            overview: "",
            language: "",
            backdropPath: "",
            genres: mockGenres
        )
        let expectedResult: [String] = [
            "mock name 1",
            "mock name 2"
        ]
        
        // WHEN
        let capturedResult = sut.badges
        
        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
    
    func test_badges_are_empty_when_genres_are_nil() throws {
        // GIVEN
        let sut = MovieListItemModelView(
            title: "",
            overview: "",
            language: "",
            backdropPath: "",
            genres: nil
        )
        let expectedResult: [String] = []
        
        // WHEN
        let capturedResult = sut.badges
        
        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
    
    
    func test_badges_are_empty_when_genres_are_empty() throws {
        // GIVEN
        let sut = MovieListItemModelView(
            title: "",
            overview: "",
            language: "",
            backdropPath: "",
            genres: []
        )
        let expectedResult: [String] = []
        
        // WHEN
        let capturedResult = sut.badges
        
        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
    
    func test_thumbnailUrl_forms_correctly_when_backdropPath_has_valid_values() throws {
        // GIVEN
        let mockBackdropPath = "mock path"
        let sut = MovieListItemModelView(
            title: "",
            overview: "",
            language: "",
            backdropPath: mockBackdropPath,
            genres: []
        )
        let expectedResult = "mock path"
        
        // WHEN
        let capturedResult = sut.thumbnailUrl

        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
}
