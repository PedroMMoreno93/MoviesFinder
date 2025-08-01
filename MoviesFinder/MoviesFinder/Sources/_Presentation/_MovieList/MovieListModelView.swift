//
//  MovieListModelView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation
import MVVM_Core

public struct MovieListModelView: BaseModelView {
    // MARK: Constants
    let emtpyStateTitle: String = "No movies to display"
    let emptyStateDescription: String = "Select another genre or change sort category."
    let errorStateTitle: String = "Something went wrong"
    let errorStateDescription: String = """
Couldn't load movies. Please retry.
If the problem persists, try rebooting the app.
"""
    let errorStateRetryButtonLabel: String = "Retry"
    let loadingStateLabel: String = "Loading Movies..."
    let genreDropDownTitle: String = "Genre"
    let sortDropDownTitle: String = "Sort"
    let loadMoreLabel: String = "Load More"

    // MARK: Variables
    var movies: [MovieListItemModelView]
    var page: Int = 1
    var sortBy: MoviesSortCategoryEntity = .popularityDescending
    var genres: [GenreEntity] = []
    var selectedGenre: GenreEntity = .all
    var selectedMovieId: Int?
    // MARK: init
    public init(
        movies: [MovieListItemModelView] = []
    ) {
        self.movies = movies
    }
}
