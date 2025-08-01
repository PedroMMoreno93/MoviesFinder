//
//  MovieListViewModelTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

// swiftlint:disable type_body_length
final class MovieListViewModelTests: XCTestCase {

    func test_fetch_genres_success_when_use_case_success() async throws {
        // GIVEN
        let mockGenres = [
            GenreEntity(id: 16, name: "Animation"),
            GenreEntity(id: 35, name: "Comedy")
        ]
        
        let genresUseCase = GetGenresList(
            repository: GetGenresRepositoryStub(
                result: mockGenres
            )
        )
        let moviesUseCase = GetMoviesList(
            repository: GetMoviesListRepositorysStub(
                result: nil
            )
        )
        
        let extepctedResult =
        [
            GenreEntity(id: 0, name: "All"),
            GenreEntity(id: 16, name: "Animation"),
            GenreEntity(id: 35, name: "Comedy")

        ]
        
        let sut = MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
        
        
        // WHEN
        await sut.fetchGenres()
        let capturedResult = sut.modelView.genres
        let capturedState = sut.state

        // THEN
        XCTAssertEqual(capturedResult, extepctedResult)
        XCTAssertEqual(capturedState, .success)
    }
    
    func test_fetch_genres_fails_when_use_case_fails() async throws {
        // GIVEN
        let genresUseCase = GetGenresList(
            repository: GetGenresRepositoryStub(
                result: nil
            )
        )
        let moviesUseCase = GetMoviesList(
            repository: GetMoviesListRepositorysStub(
                result: nil
            )
        )
        
        let sut = MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
        
        
        // WHEN
        await sut.fetchGenres()
        let capturedGenresResult = sut.modelView.genres
        let capturedState = sut.state

        // THEN
        XCTAssertEqual(capturedGenresResult, [])
        XCTAssertEqual(capturedState, .failure)
    }
    
    // swiftlint:disable function_body_length
    func test_fetch_movies_success_when_use_case_success() async throws {
        // GIVEN
        let mockMovies = [
            MoviesListItemEntity(
                adult: false,
                backdropPath: nil,
                genreIDS: [
                    16
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
                genreIDS: [
                    12
                ],
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

        let mockGenres =
        [
            GenreEntity(id: 16, name: "Animation"),
            GenreEntity(id: 12, name: "Comedy")

        ]
        
        
        let genresUseCase = GetGenresList(
            repository: GetGenresRepositoryStub(
                result: mockGenres
            )
        )
        let moviesUseCase = GetMoviesList(
            repository: GetMoviesListRepositorysStub(
                result: mockMovies
            )
        )
        
        let sut = MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
        
        
        // WHEN
        await sut.fetchGenres()
        await sut.fetchMovies()
        let capturedResult = sut.modelView.movies
        let capturedState = sut.state

        // THEN
        XCTAssertFalse(capturedResult.isEmpty)
        XCTAssertEqual(capturedState, .success)
    }
    // swiftlint:enable function_body_length

    func test_fetch_movies_fails_when_use_case_fails() async throws {
        // GIVEN
        let genresUseCase = GetGenresList(
            repository: GetGenresRepositoryStub(
                result: nil
            )
        )
        let moviesUseCase = GetMoviesList(
            repository: GetMoviesListRepositorysStub(
                result: nil
            )
        )
        
        let sut = MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
        
        
        // WHEN
        await sut.fetchMovies()
        let capturedResult = sut.modelView.movies
        let capturedState = sut.state
        let capturedShowErrorView = sut.showErrorView

        // THEN
        XCTAssertTrue(capturedResult.isEmpty)
        XCTAssertEqual(capturedState, .failure)
        XCTAssertTrue(capturedShowErrorView)
    }
    
    // swiftlint:disable function_body_length
    func test_fetch_more_movies_success_when_use_case_success() async throws {
        // GIVEN
        let mockMovies = [
            MoviesListItemEntity(
                adult: false,
                backdropPath: nil,
                genreIDS: [
                    16
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
                genreIDS: [
                    12
                ],
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

        let mockGenres =
        [
            GenreEntity(id: 16, name: "Animation"),
            GenreEntity(id: 12, name: "Comedy")

        ]
        
        
        let genresUseCase = GetGenresList(
            repository: GetGenresRepositoryStub(
                result: mockGenres
            )
        )
        let moviesUseCase = GetMoviesList(
            repository: GetMoviesListRepositorysStub(
                result: mockMovies
            )
        )
        
        let sut = MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
        
        
        // WHEN
        await sut.fetchGenres()
        await sut.fetchMoreMovies()
        let capturedResult = sut.modelView.movies
        let capturedState = sut.state

        // THEN
        XCTAssertFalse(capturedResult.isEmpty)
        XCTAssertEqual(capturedState, .success)
    }
    // swiftlint:enable function_body_length

    func test_fetch_more_movies_fails_when_use_case_fails_and_resets_page() async throws {
        // GIVEN
        let genresUseCase = GetGenresList(
            repository: GetGenresRepositoryStub(
                result: nil
            )
        )
        let moviesUseCase = GetMoviesList(
            repository: GetMoviesListRepositorysStub(
                result: nil
            )
        )
        
        let sut = MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
        
        sut.modelView.page = 2
        
        // WHEN
        await sut.fetchMoreMovies()
        let capturedResult = sut.modelView.movies
        let capturedState = sut.state
        let capturedPage = sut.modelView.page

        // THEN
        XCTAssertTrue(capturedResult.isEmpty)
        XCTAssertEqual(capturedState, .failure)
        XCTAssertEqual(capturedPage, 1)
    }
    
    func test_fetch_more_movies_fails_when_use_case_fails_and_doesnt_reset_page() async throws {
        // GIVEN
        let genresUseCase = GetGenresList(
            repository: GetGenresRepositoryStub(
                result: nil
            )
        )
        let moviesUseCase = GetMoviesList(
            repository: GetMoviesListRepositorysStub(
                result: nil
            )
        )
        
        let sut = MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
                
        // WHEN
        await sut.fetchMoreMovies()
        let capturedResult = sut.modelView.movies
        let capturedState = sut.state
        let capturedPage = sut.modelView.page

        // THEN
        XCTAssertTrue(capturedResult.isEmpty)
        XCTAssertEqual(capturedState, .failure)
        XCTAssertEqual(capturedPage, 1)
    }
    
    func test_next_page_success() throws {
        // GIVEN
        let genresUseCase = GetGenresList(
            repository: GetGenresRepositoryStub(
                result: nil
            )
        )
        let moviesUseCase = GetMoviesList(
            repository: GetMoviesListRepositorysStub(
                result: nil
            )
        )
        
        let sut = MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
        
        let expectedResult = 2
        
        // WHEN
        sut.nextPage()
        let capturedResult = sut.modelView.page

        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
    
    func test_reset_page_success() throws {
        // GIVEN
        let genresUseCase = GetGenresList(
            repository: GetGenresRepositoryStub(
                result: nil
            )
        )
        let moviesUseCase = GetMoviesList(
            repository: GetMoviesListRepositorysStub(
                result: nil
            )
        )
        
        let sut = MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
        
        let expectedResult = 1
        
        // WHEN
        sut.nextPage()
        sut.resetPage()
        let capturedResult = sut.modelView.page

        // THEN
        XCTAssertEqual(capturedResult, expectedResult)
    }
}
// swiftlint:enable type_body_length
