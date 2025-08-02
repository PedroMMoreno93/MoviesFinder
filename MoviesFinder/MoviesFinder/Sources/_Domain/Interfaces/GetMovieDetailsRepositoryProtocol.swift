//
//  GetMovieDetailsRepositoryProtocol.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public protocol GetMovieDetailsRepositoryProtocol {
    func getDetails(
        _ movieId: Int
    ) async throws -> MovieDetailsEntity
}
