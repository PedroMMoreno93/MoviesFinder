//
//  DataConstants.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation
import NetworkSystem
import Utils

public enum DataConstants {
    public enum URLs {
        public static let imagesBaseURL: String = "https://image.tmdb.org/t/p/original"
        public static let apiBaseURL: String = "https://api.themoviedb.org/3/"
    }
    
    public enum Endpoints {
        public static let movies: String = "discover/movie"
        public static let genres: String = "genre/movie/list"
        public static func movieDetails(_ movieId: Int) -> String {
           return "movie/\(movieId)"
        }
        public static func movieCredits(_ movieId: Int) -> String {
            return "movie/\(movieId)/credits"
        }
    }
   
    // swiftlint:disable line_length
    public static let apiKey: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNDhhMTBhYjBiOWVlODU4NjVkMGMyMzI2YzlkYjUzZCIsIm5iZiI6MTc1Mzg1NDc2NC45NTEsInN1YiI6IjY4ODliMzJjZjg2ZTFkYjVhNjg0YmUzOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eM4eU8V-llyrhijKevhWsWOMLWG4-p9srG1EtimCOr4"
    // swiftlint:enable line_length
    
    public static var language: NetworkRequestQueryParams {
        NetworkRequestQueryParams(
            key: "language",
            value: LanguageUtils.getLanguageCode()
        )
    }
}
