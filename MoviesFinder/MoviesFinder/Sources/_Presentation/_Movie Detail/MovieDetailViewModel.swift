//
//  MovieDetailViewModel.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import MVVM_Core
import SwiftUI

public class MovieDetailViewModel: BaseViewModel {
    @Published public var modelView: MovieDetailModelView
    @Published public var state: ViewModelState
    @Published public var showAlert: Bool
    
    private let detailsUseCase: GetMovieDetailsUseCase
    private let creditsUseCase: GetMovieCreditsUseCase
        
    public init(
        movieId: Int,
        state: ViewModelState = .initial,
        showAlert: Bool = false,
        detailsUseCase: GetMovieDetailsUseCase,
        creditsUseCase: GetMovieCreditsUseCase
    ) {
        self.state = state
        self.showAlert = showAlert
        self.detailsUseCase = detailsUseCase
        self.creditsUseCase = creditsUseCase
        self.modelView = MovieDetailModelView(movieId: movieId)
    }
    
    @MainActor
    public func onAppear() async {
        await self.fetchCredits()
        await self.fetcDetails()
    }
    
    @MainActor
    public func fetchCredits() async {
        do {
            self.state = .loading
            let credits = try await creditsUseCase.execute(
                modelView.movieId
            )
            self.modelView.credits = credits
            self.state = .success
        } catch {
            self.showAlert = false
            self.state = .failure
            // If it fails the alert won't be shown
        }
    }
    
    @MainActor
    public func fetcDetails() async {
        do {
            self.state = .loading
            let details = try await detailsUseCase.execute(
                modelView.movieId
            )
            self.modelView.details = details
            self.state = .success
        } catch {
            self.showAlert = true
            self.state = .failure
        }
    }
    
}
