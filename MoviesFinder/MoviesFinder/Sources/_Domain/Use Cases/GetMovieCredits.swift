//
//  GetMovieCredits.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public protocol GetMovieCreditsUseCase {
    func execute(
        _ movieId: Int
    ) async throws -> MovieCreditsEntity
}

public class GetMovieCredits: GetMovieCreditsUseCase {
    private let repository: GetMovieCreditsRepositoryProtocol
    
    public init(repository: GetMovieCreditsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(
        _ movieId: Int
    )
    async throws -> MovieCreditsEntity {
        do {
            let response = try await repository.getCredits(movieId)
            return response
        } catch {
            throw error
        }
    }
}
