//
//  MovieListItemModelView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation
import UIComponents

public struct MovieListItemModelView: MovieCardModelView {
    public let id = UUID()
    public let movieId: Int
    public let title: String
    public let overview: String
    public let language: String
    public let backdropPath: String?
    public let genres: [GenreEntity]?

    public var description: String {
        return overview
    }
    
    public var badges: [String] {
        guard let genres = genres,
              !genres.isEmpty
        else {
             return []
        }
        
        return genres.compactMap { genre in
            return genre.name
        }
    }
    
    public var thumbnailUrl: String? {
        return backdropPath
    }
    
    public init(
        movieId: Int,
        title: String,
        overview: String,
        language: String,
        backdropPath: String?,
        genres: [GenreEntity]?
    ) {
        self.movieId = movieId
        self.title = title
        self.overview = overview
        self.language = language
        self.backdropPath = backdropPath
        self.genres = genres
    }
}

extension MovieListItemModelView {
    public init(
        from entity: MoviesListItemEntity,
        genreEntities: [GenreEntity]
    ) {
        self.movieId = entity.id
        self.title = entity.title
        self.overview = entity.overview
        self.language = entity.originalLanguage
        self.backdropPath = entity.backdropPath
        if !entity.genreIDS.isEmpty {
            let foundGenres = genreEntities.filter { genreEntity in
                return entity.genreIDS.contains { id in
                    id == genreEntity.id
                }
            }
            
            if foundGenres.isEmpty {
                self.genres = nil
            } else {
                self.genres = foundGenres
            }
        } else {
            self.genres = nil
        }
    }
}
