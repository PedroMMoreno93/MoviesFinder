//
//  GetGenresList.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation

public protocol GetGenresListUseCase {
    func execute() async throws -> [GenreEntity]
}

public class GetGenresList: GetGenresListUseCase {
    private let repository: GetGenresListRepositoryProtocol
    
    public init(repository: GetGenresListRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() async throws -> [GenreEntity] {
        do {
            let response = try await repository.getGenres()
            return response
        } catch {
            throw error
        }
    }
}
