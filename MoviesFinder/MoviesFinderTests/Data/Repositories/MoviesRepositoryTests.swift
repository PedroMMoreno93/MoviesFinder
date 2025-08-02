//
//  MoviesRepositoryTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class MoviesRepositoryTests: XCTestCase {

    // swiftlint:disable function_body_length
    func test_getmovies_returns_success() async throws {
        // GIVEN
        let result = MovieListResponseModel(
            page: 1,
            results: [
                MovieListItemResponseModel(
                    adult: false,
                    backdropPath: "/1RgPyOhN4DRs225BGTlHJqCudII.jpg",
                    genreIDS: [
                        16,
                        28,
                        14,
                        53
                    ],
                    id: 1311031,
                    originalLanguage: "ja",
                    originalTitle: "劇場版「鬼滅の刃」無限城編 第一章 猗窩座再来",
                    overview: "mock overview 1",
                    popularity: 600.6803,
                    posterPath: "/aFRDH3P7TX61FVGpaLhKr6QiOC1.jpg",
                    releaseDate: "2025-07-18",
                    title: "Demon Slayer: Kimetsu no Yaiba Infinity Castle",
                    video: false,
                    voteAverage: 6.86,
                    voteCount: 43
                ),
                MovieListItemResponseModel(
                    adult: false,
                    backdropPath: nil,
                    genreIDS: nil,
                    id: 1071585,
                    originalLanguage: "en",
                    originalTitle: "M3GAN 2.0",
                    overview: "mock overview 2",
                    popularity: nil,
                    posterPath: nil,
                    releaseDate: "2025-06-25",
                    title: "M3GAN 2.0",
                    video: nil,
                    voteAverage: nil,
                    voteCount: nil
                )
            ],
            totalPages: 2688,
            totalResults: 53747
        )

        let expectedResult = [
            MoviesListItemEntity(
                adult: false,
                backdropPath: "/1RgPyOhN4DRs225BGTlHJqCudII.jpg",
                genreIDS: [
                    16,
                    28,
                    14,
                    53
                ],
                id: 1311031,
                originalLanguage: "ja",
                originalTitle: "劇場版「鬼滅の刃」無限城編 第一章 猗窩座再来",
                overview: "mock overview 1",
                popularity: 600.6803,
                posterPath: "/aFRDH3P7TX61FVGpaLhKr6QiOC1.jpg",
                releaseDate: "2025-07-18",
                title: "Demon Slayer: Kimetsu no Yaiba Infinity Castle",
                video: false,
                voteAverage: 6.86,
                voteCount: 43
            ),
            MoviesListItemEntity(
                adult: false,
                backdropPath: nil,
                genreIDS: [],
                id: 1071585,
                originalLanguage: "en",
                originalTitle: "M3GAN 2.0",
                overview: "mock overview 2",
                popularity: 0,
                posterPath: nil,
                releaseDate: "2025-06-25",
                title: "M3GAN 2.0",
                video: false,
                voteAverage: 0,
                voteCount: 0
            )
        ]
        
        let apiDataSource = ApiDataSourceMoviesStub(
            result: result
        )
        
        let sut = MoviesRepository(
            apiDataSourceMovies: apiDataSource,
            moviesDomainMapper: MoviesDomainMapper(),
            moviesSortCategoryDomainMapper: MoviesSortCategoryDomainMapper(),
            genresDomainMapper: GenresDomainMapper()
        )
        
        // WHEN
        let capturedResult = try? await sut.getMovies(
            page: 1,
            sortBy: .popularityAscending,
            genres: []
        )
        
        // THEN
        XCTAssertNotNil(capturedResult)
        XCTAssertEqual(capturedResult, expectedResult)
    }
    // swiftlint:enable function_body_length

    func test_getgenres_returns_fails() async throws {
        // GIVEN
        let result: MovieListResponseModel? = nil
       
        let apiDataSource = ApiDataSourceMoviesStub(
            result: result
        )
        let sut = MoviesRepository(
            apiDataSourceMovies: apiDataSource,
            moviesDomainMapper: MoviesDomainMapper(),
            moviesSortCategoryDomainMapper: MoviesSortCategoryDomainMapper(),
            genresDomainMapper: GenresDomainMapper()
        )
                
        // WHEN
        do {
            _ = try await sut.getMovies(
                page: 1,
                sortBy: .popularityAscending,
                genres: []
            )
            XCTFail("Expected error, got successful response")
            return
        } catch {
            // THEN
            guard let apiError = error as? ApiDataSourceMoviesStubError
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
