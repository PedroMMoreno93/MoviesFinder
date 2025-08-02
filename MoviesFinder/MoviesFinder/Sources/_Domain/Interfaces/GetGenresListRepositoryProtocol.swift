//
//  GetGenresListRepositoryProtocol.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation

public protocol GetGenresListRepositoryProtocol {
    func getGenres() async throws -> [GenreEntity]
}
