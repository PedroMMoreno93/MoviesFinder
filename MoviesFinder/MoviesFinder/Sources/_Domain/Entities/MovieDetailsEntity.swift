//
//  MovieDetailsEntity.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public struct MovieDetailsEntity {
    let title: String
    let overview: String
    let language: String?
    let backdropPath: String?
    let country: String
    let releaseDate: String?
    let genres: [GenreEntity]
}
