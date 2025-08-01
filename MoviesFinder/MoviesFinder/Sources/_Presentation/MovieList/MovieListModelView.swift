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
    // swiftlint:disable line_length
    let errorStateDescription: String = "Couldn't load movies. Please retry.\nIf the problem persist, try rebooting the app."
    // swiftlint:enable line_length
    let errorStateRetryButtonLabel: String = "Retry"
    let loadingStateLabel: String = "Loading..."
    let genreDropDownTitle: String = "Genre"
    let sortDropDownTitle: String = "Sort"
    let loadMoreLabel: String = "Load More"

    // MARK: Variables
    var movies: [MovieListItemModelView]
    var page: Int = 1
    var sortBy: MoviesSortCategoryEntity = .popularityDescending
    var genres: [GenreEntity] = []
    var selectedGenre: GenreEntity = .all
    
    // MARK: init
    public init(
        movies: [MovieListItemModelView] = []
    ) {
        self.movies = movies
    }
}
