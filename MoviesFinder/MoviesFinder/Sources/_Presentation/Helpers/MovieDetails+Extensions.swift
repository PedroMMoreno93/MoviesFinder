//
//  MovieDetails+Extensions.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

extension MovieDetailsEntity {
    public static let empty = MovieDetailsEntity(
        title: "",
        overview: "",
        language: nil,
        backdropPath: nil,
        country: "",
        releaseDate: nil,
        genres: []
    )
}
