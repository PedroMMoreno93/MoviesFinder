//
//  MovieDetailModelView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import MVVM_Core
import Foundation

public struct MovieDetailModelView: BaseModelView {
    // MARK: Constants
    let movieId: Int
    let loadingStateLabel: String = "Loading Details..."
    let errorAlertTitle: String = "Something went wrong"
    let errorAlertButtonLabel: String = "Something went wrong"

    let overViewTitle: String = "Overview"
    let castTitle: String = "Characters"
    let crewTitle: String = "Crew"

    // MARK: Variables
    var details: MovieDetailsEntity = .empty
    var credits: MovieCreditsEntity = .empty

    // MARK: init
    public init(
        movieId: Int = 0
    ) {
        self.movieId = movieId
    }
}
