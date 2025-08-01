//
//  MovieListFactory.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import NetworkSystem

class MovieListFactory {
    static func create() -> MovieListView {
        return MovieListView(
            viewModel: createViewModel()
        )
    }
    
    private static func createViewModel() -> MovieListViewModel {
        return MovieListViewModel(
            moviesUseCase: createMoviesUseCase(),
            genresUseCase: createGenresUseCase()
        )
    }
    
    private static func createMoviesUseCase() -> GetMoviesListUseCase {
        return GetMoviesList(
            repository: createMoviesRepository()
        )
    }
    
    private static func createGenresUseCase() -> GetGenresListUseCase {
        return GetGenresList(
            repository: createGenresRepository()
        )
    }
    
    private static func createMoviesRepository() -> GetMoviesListRepositoryProtocol {
        return MoviesRepository(
            apiDataSourceMovies: createApiDataSourceMovies(),
            moviesDomainMapper: createMoviesDomainMapper(),
            moviesSortCategoryDomainMapper: createMoviesSortCategoryDomainMapper(),
            genresDomainMapper: createGenresDomainMapper()
        )
    }
    
    private static func createGenresRepository() -> GetGenresListRepositoryProtocol {
        return GenresRepository(
            apiDataSourceGenres: createApiDataSourceGenres(),
            genresDomainMapper: createGenresDomainMapper()
        )
    }
    
    private static func createApiDataSourceMovies() -> ApiDataSourceMoviesProtocol {
        return ApiDataSourceMovies(
            networkClient: createNetworkClient()
        )
    }
    
    private static func createApiDataSourceGenres() -> ApiDataSourceGenresProtocol {
        return ApiDataSourceGenres(
            networkClient: createNetworkClient()
        )
    }
    
    private static func createMoviesDomainMapper() -> MoviesDomainMapper {
      return MoviesDomainMapper()
    }
    
    private static func createMoviesSortCategoryDomainMapper()
    -> MoviesSortCategoryDomainMapper {
      return MoviesSortCategoryDomainMapper()
    }
    
    private static func createGenresDomainMapper()
    -> GenresDomainMapper {
      return GenresDomainMapper()
    }
    
    private static func createNetworkClient()
    -> NetworkManager {
      return NetworkManager()
    }

}
