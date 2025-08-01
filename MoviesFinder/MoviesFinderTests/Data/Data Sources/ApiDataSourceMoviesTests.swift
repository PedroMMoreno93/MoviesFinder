//
//  ApiDataSourceMoviesTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class ApiDataSourceMoviesTests: XCTestCase {
    
    // swiftlint:disable function_body_length
    func test_fetchMovies_succeeds_when_networkclient_requests_succeeds_and_response_is_correct() async throws {
        // GIVEN
        // swiftlint:disable line_length
        let jsonData = """
             {
               "page": 1,
               "results": [
                 {
                   "adult": false,
                   "backdrop_path": "/1RgPyOhN4DRs225BGTlHJqCudII.jpg",
                   "genre_ids": [
                     16,
                     28,
                     14,
                     53
                   ],
                   "id": 1311031,
                   "original_language": "ja",
                   "original_title": "劇場版「鬼滅の刃」無限城編 第一章 猗窩座再来",
                   "overview": "As the Demon Slayer Corps members and Hashira engaged in a group strength training program, the Hashira Training, in preparation for the forthcoming battle against the demons, Muzan Kibutsuji appears at the Ubuyashiki Mansion. With the head of the Demon Corps in danger, Tanjiro and the Hashira rush to the headquarters but are plunged into a deep descent to a mysterious space by the hands of Muzan Kibutsuji.  The destination of where Tanjiro and Demon Slayer Corps have fallen is the demons' stronghold – the Infinity Castle. And so, the battleground is set as the final battle between the Demon Slayer Corps and the demons ignites.",
                   "popularity": 600.6803,
                   "poster_path": "/aFRDH3P7TX61FVGpaLhKr6QiOC1.jpg",
                   "release_date": "2025-07-18",
                   "title": "Demon Slayer: Kimetsu no Yaiba Infinity Castle",
                   "video": false,
                   "vote_average": 6.86,
                   "vote_count": 43
                 },
                 {
                   "adult": false,
                   "backdrop_path": "/cEQMqB3ahd4mfeUN6VGC0ouVnZZ.jpg",
                   "genre_ids": [
                     28,
                     878,
                     53
                   ],
                   "id": 1071585,
                   "original_language": "en",
                   "original_title": "M3GAN 2.0",
                   "overview": "After the underlying tech for M3GAN is stolen and misused by a powerful defense contractor to create a military-grade weapon known as Amelia, M3GAN's creator Gemma realizes that the only option is to resurrect M3GAN and give her a few upgrades, making her faster, stronger, and more lethal.",
                   "popularity": 410.1184,
                   "poster_path": "/oekamLQrwlJjRNmfaBE4llIvkir.jpg",
                   "release_date": "2025-06-25",
                   "title": "M3GAN 2.0",
                   "video": false,
                   "vote_average": 7.6,
                   "vote_count": 555
                 }
               ],
               "total_pages": 2688,
               "total_results": 53747
             }
            """
        // swiftlint:enable line_length

        let data = Data(jsonData.utf8)
        // swiftlint:disable line_length
        let expectedResult = MovieListResponseModel(
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
                    overview: "As the Demon Slayer Corps members and Hashira engaged in a group strength training program, the Hashira Training, in preparation for the forthcoming battle against the demons, Muzan Kibutsuji appears at the Ubuyashiki Mansion. With the head of the Demon Corps in danger, Tanjiro and the Hashira rush to the headquarters but are plunged into a deep descent to a mysterious space by the hands of Muzan Kibutsuji.  The destination of where Tanjiro and Demon Slayer Corps have fallen is the demons' stronghold – the Infinity Castle. And so, the battleground is set as the final battle between the Demon Slayer Corps and the demons ignites.",
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
                    backdropPath: "/cEQMqB3ahd4mfeUN6VGC0ouVnZZ.jpg",
                    genreIDS: [
                        28,
                        878,
                        53
                    ],
                    id: 1071585,
                    originalLanguage: "en",
                    originalTitle: "M3GAN 2.0",
                    overview: "After the underlying tech for M3GAN is stolen and misused by a powerful defense contractor to create a military-grade weapon known as Amelia, M3GAN's creator Gemma realizes that the only option is to resurrect M3GAN and give her a few upgrades, making her faster, stronger, and more lethal.",
                    popularity: 410.1184,
                    posterPath: "/oekamLQrwlJjRNmfaBE4llIvkir.jpg",
                    releaseDate: "2025-06-25",
                    title: "M3GAN 2.0",
                    video: false,
                    voteAverage: 7.6,
                    voteCount: 555
                )
            ],
            totalPages: 2688,
            totalResults: 53747
        )
        // swiftlint:enable line_length

        let sut = ApiDataSourceMovies(
            networkClient: NetworkManagerStub(result: data)
        )
        
        // WHEN
        let page = 1
        let capturedResult = try? await sut.fetchMovies(
            page: page,
            sortBy: "",
            genres: []
        )
        
        // THEN
        XCTAssertNotNil(capturedResult)
        XCTAssertEqual(capturedResult, expectedResult)
        XCTAssertEqual(capturedResult?.page, page)
    }
    // swiftlint:enable function_body_length

    func test_ffetchMovies_fails_when_networkclient_requests_fails() async {
        // GIVEN
        let data: Data? = nil
        let sut = ApiDataSourceMovies(
            networkClient: NetworkManagerStub(result: data)
        )
        
        // WHEN
        let capturedResult = try? await sut.fetchMovies(
            page: 1,
            sortBy: "",
            genres: []
        )
        
        // THEN
        XCTAssertNil(capturedResult)
    }
    
    func test_fetchMovies_fails_when_networkclientt_requests_succeeds_and_response_is_not_correct() async throws {
        // GIVEN
        // swiftlint:disable line_length
        let jsonData = """
             {
               "page": 1,
               "results": [
                 {
                   "adult": false,
                   "backdrop_path": "/1RgPyOhN4DRs225BGTlHJqCudII.jpg",
                   "genre_ids": [
                     "16",
                     "28",
                     "14",
                     "53"
                   ],
                   "id": "1311031",
                   "original_language": "ja",
                   "original_title": "劇場版「鬼滅の刃」無限城編 第一章 猗窩座再来",
                   "overview": "As the Demon Slayer Corps members and Hashira engaged in a group strength training program, the Hashira Training, in preparation for the forthcoming battle against the demons, Muzan Kibutsuji appears at the Ubuyashiki Mansion. With the head of the Demon Corps in danger, Tanjiro and the Hashira rush to the headquarters but are plunged into a deep descent to a mysterious space by the hands of Muzan Kibutsuji.  The destination of where Tanjiro and Demon Slayer Corps have fallen is the demons' stronghold – the Infinity Castle. And so, the battleground is set as the final battle between the Demon Slayer Corps and the demons ignites.",
                   "popularity": 600.6803,
                   "poster_path": "/aFRDH3P7TX61FVGpaLhKr6QiOC1.jpg",
                   "release_date": "2025-07-18",
                   "title": "Demon Slayer: Kimetsu no Yaiba Infinity Castle",
                   "video": false,
                   "vote_average": 6.86,
                   "vote_count": 43
                 },
                 {
                   "adult": false,
                   "backdrop_path": "/cEQMqB3ahd4mfeUN6VGC0ouVnZZ.jpg",
                   "genre_ids": [
                     "28",
                     "878",
                     "53"
                   ],
                   "id": "1071585",
                   "original_language": "en",
                   "original_title": "M3GAN 2.0",
                   "overview": "After the underlying tech for M3GAN is stolen and misused by a powerful defense contractor to create a military-grade weapon known as Amelia, M3GAN's creator Gemma realizes that the only option is to resurrect M3GAN and give her a few upgrades, making her faster, stronger, and more lethal.",
                   "popularity": 410.1184,
                   "poster_path": "/oekamLQrwlJjRNmfaBE4llIvkir.jpg",
                   "release_date": "2025-06-25",
                   "title": "M3GAN 2.0",
                   "video": false,
                   "vote_average": 7.6,
                   "vote_count": 555
                 }
               ],
               "total_pages": 2688,
               "total_results": 53747
             }
            """
        // swiftlint:enable line_length
        
        let data = Data(jsonData.utf8)
        let sut = ApiDataSourceMovies(
            networkClient: NetworkManagerStub(result: data)
        )
        
        // WHEN
        do {
            _ = try await sut.fetchMovies(
                page: 1,
                sortBy: "",
                genres: []
            )
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
