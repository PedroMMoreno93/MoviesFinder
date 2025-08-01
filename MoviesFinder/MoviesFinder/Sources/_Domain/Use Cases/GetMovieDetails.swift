//
//  GetMovieDetails.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public protocol GetMovieDetailsUseCase {
    func execute(
        _ movieId: Int
    ) async throws -> MovieDetailsEntity
}

public class GetMovieDetails: GetMovieDetailsUseCase {
    private let repository: GetMovieDetailsRepositoryProtocol
    
    public init(repository: GetMovieDetailsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(
        _ movieId: Int
    ) async throws -> MovieDetailsEntity {
        do {
            let response = try await repository.getDetails(movieId)
            return response
        } catch {
            throw error
        }
    }
}
