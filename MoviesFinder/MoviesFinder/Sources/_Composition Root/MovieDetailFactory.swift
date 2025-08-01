//
//  MovieDetailFactory.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import NetworkSystem

public protocol CreateMovieDetailView {
    static func create(
        movieId: Int,
        backButtonAction: (() -> Void)?
    ) -> MovieDetailView
}

enum MovieDetailFactory: CreateMovieDetailView {
    public static func create(
        movieId: Int,
        backButtonAction: (() -> Void)?
    ) -> MovieDetailView {
        
        let viewModel = MovieDetailViewModel(
            movieId: movieId,
            detailsUseCase: createMovieDetailsUseCase(),
            creditsUseCase: createMovieCreditssUseCase()
        )
        return MovieDetailView(
            viewModel: viewModel,
            backButtonAction: backButtonAction
        )
    }
    
    private static func createMovieDetailsUseCase() -> GetMovieDetailsUseCase {
        return GetMovieDetails(
            repository: createMovieDetailsRepository()
        )
    }
    
    private static func createMovieCreditssUseCase() -> GetMovieCreditsUseCase {
        return GetMovieCredits(
            repository: createMovieCreditsRepository()
        )
    }
    
    private static func createMovieDetailsRepository() -> GetMovieDetailsRepositoryProtocol {
        return MovieDetailsRepository(
            apiDataSourceDetails: createApiDataSourceMovieDetails(),
            detailsDomainMapper: MovieDetailsDomainMapper()
        )
    }
    
    private static func createMovieCreditsRepository() -> GetMovieCreditsRepositoryProtocol {
        return MovieCreditsRepository(
            apiDataSourceCredits: createApiDataSourceMovieCredits(),
            creditsDomainMapper: MovieCreditsDomainMapper()
        )
    }
    
    private static func createApiDataSourceMovieDetails() -> ApiDataSourceMovieDetailsProtocol {
        return ApiDataSourceMovieDetails(
            networkClient: createNetworkClient()
        )
    }
    
    private static func createApiDataSourceMovieCredits() -> ApiDataSourceMovieCreditsProtocol {
        return ApiDataSourceMovieCredits(
            networkClient: createNetworkClient()
        )
    }
    
    private static func createNetworkClient()
    -> NetworkManager {
        return NetworkManager()
    }
}
