//
//  Equatable.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation
@testable import MoviesFinder

extension MoviesListItemEntity: @retroactive Equatable {
    public static func == (
        lhs: MoviesListItemEntity,
        rhs: MoviesListItemEntity
    ) -> Bool {
        return lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.overview == rhs.overview
    }
}

extension GenresListResponseModel: @retroactive Equatable {
    public static func == (
        lhs: GenresListResponseModel,
        rhs: GenresListResponseModel
    ) -> Bool {
        return lhs.genres == rhs.genres
    }
}

extension GenresListItemResponseModel: @retroactive Equatable {
    public static func == (
        lhs: GenresListItemResponseModel,
        rhs: GenresListItemResponseModel
    ) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
    }
}

extension MovieListResponseModel: @retroactive Equatable {
    public static func == (
        lhs: MovieListResponseModel,
        rhs: MovieListResponseModel
    ) -> Bool {
        return lhs.page == rhs.page
        && lhs.results == rhs.results
        && lhs.totalPages == rhs.totalPages
        && lhs.totalResults == rhs.totalResults
    }
}

extension MovieListItemResponseModel: @retroactive Equatable {
    public static func == (
        lhs: MovieListItemResponseModel,
        rhs: MovieListItemResponseModel
    ) -> Bool {
        return lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.overview == rhs.overview
        && lhs.originalLanguage == rhs.originalLanguage
    }
}
