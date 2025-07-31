//
//  MoviesListEntities.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation

public struct MoviesListItemEntity {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
