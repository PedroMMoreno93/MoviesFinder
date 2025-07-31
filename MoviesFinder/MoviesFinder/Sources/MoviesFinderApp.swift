//
//  MoviesFinderApp.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import SwiftUI
import NetworkSystem

@main
struct MoviesFinderApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(
                viewModel: MovieListViewModel(
                    moviesUseCase: GetMoviesList(
                        repository: MoviesRepository(
                            apiDataSourceMovies: ApiDataSourceMovies(
                                networkClient: NetworkManager()
                            ),
                            moviesDomainMapper: MoviesDomainMapper(),
                            moviesSortCategoryDomainMapper: MoviesSortCategoryDomainMapper()
                        )
                    ),
                    genresUseCase: GetGenresList(
                        repository: GenresRepository(
                            apiDataSourceGenres: ApiDataSourceGenres(
                                networkClient: NetworkManager()
                            ),
                            genresDomainMapper: GenresDomainMapper()
                        )
                    )
                )
            )
            .frame(
                maxWidth: NSScreen.main?.frame.width ?? 800,
                maxHeight: NSScreen.main?.frame.height ?? 600
            )
        }
    }
}
