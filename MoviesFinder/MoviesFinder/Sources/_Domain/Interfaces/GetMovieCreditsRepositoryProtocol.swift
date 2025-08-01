//
//  GetMovieCreditsRepositoryProtocol.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public protocol GetMovieCreditsRepositoryProtocol {
    func getCredits(
        _ movieId: Int
    ) async throws -> MovieCreditsEntity
}
