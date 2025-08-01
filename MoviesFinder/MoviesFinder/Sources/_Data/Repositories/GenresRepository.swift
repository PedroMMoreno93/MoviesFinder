//
//  GenresRepository.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation

public class GenresRepository: GetGenresListRepositoryProtocol {
    private let apiDataSourceGenres: ApiDataSourceGenresProtocol
    private let genresDomainMapper: GenresDomainMapper

    public init(
        apiDataSourceGenres: ApiDataSourceGenresProtocol,
        genresDomainMapper: GenresDomainMapper
    ) {
        self.apiDataSourceGenres = apiDataSourceGenres
        self.genresDomainMapper = genresDomainMapper
    }
    
    public func getGenres() async throws -> [GenreEntity] {
        let response = try await apiDataSourceGenres.fetchGenres()
        let entities = genresDomainMapper.map(responseModel: response)
        return entities
    }
}
