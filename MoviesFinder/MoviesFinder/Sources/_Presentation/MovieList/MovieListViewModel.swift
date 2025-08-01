//
//  MovieListViewModel.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import MVVM_Core
import SwiftUI

public class MovieListViewModel: BaseViewModel {
    @Published public var modelView: MovieListModelView
    @Published public var state: ViewModelState
    @Published public var showErrorView: Bool

    private let moviesUseCase: GetMoviesListUseCase
    private let genresUseCase: GetGenresListUseCase
    
    public init(
        modelView: MovieListModelView = MovieListModelView(),
        state: ViewModelState = .initial,
        showErrorView: Bool = false,
        moviesUseCase: GetMoviesListUseCase,
        genresUseCase: GetGenresListUseCase
    ) {
        self.modelView = modelView
        self.state = state
        self.showErrorView = showErrorView
        self.moviesUseCase = moviesUseCase
        self.genresUseCase = genresUseCase
    }
    
    @MainActor
    public func onAppear() async {
        await self.fetchGenres()
        await self.fetchMovies()
    }
    
    @MainActor
    public func fetchGenres() async {
        do {
            self.state = .loading
            let genres = try await genresUseCase.execute()
            self.modelView.genres = [.all]
            self.modelView.genres.append(contentsOf: genres)
            self.state = .success
        } catch {
            self.showErrorView = false
            self.state = .failure
            // If it fails the selector won't be shown
        }
    }
    
    @MainActor
    public func fetchMovies() async {
        do {
            self.state = .loading
            let movies = try await moviesUseCase.execute(
                page: modelView.page,
                sortBy: modelView.sortBy,
                genres: modelView.selectedGenre == GenreEntity.all ? [] : [modelView.selectedGenre]
            )
            self.modelView.movies = movies.compactMap { movie in
                MovieListItemModelView(
                    from: movie,
                    genreEntities: modelView.genres
                )
            }
            self.state = .success
        } catch {
            self.state = .failure
            self.showErrorView = true
        }
    }
    
    @MainActor
    public func fetchMoreMovies() async {
        do {
            self.state = .loading
            let movies = try await moviesUseCase.execute(
                page: modelView.page,
                sortBy: modelView.sortBy,
                genres: modelView.selectedGenre == GenreEntity.all ? [] : [modelView.selectedGenre]
            )
            let mappedMovies = movies.compactMap { movie in
                MovieListItemModelView(
                    from: movie,
                    genreEntities: modelView.genres
                )
            }
            
            self.modelView.movies.append(contentsOf: mappedMovies)
            self.state = .success
        } catch {
            self.state = .failure
            guard self.modelView.page > 1
            else {
                return
            }
            self.modelView.page -= 1
        }
    }
    
    public func nextPage() {
        self.modelView.page += 1
    }
    
    public func resetPage() {
        self.modelView.page = 1
    }
}
