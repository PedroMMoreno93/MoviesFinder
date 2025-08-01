//
//  MoviesSortCategoryEntity+Extensions.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation

extension MoviesSortCategoryEntity {
    var label: String {
        switch self {
        case .titleAscending:
            "Title asc"
        case .titleDescending:
            "Title desc"
        case .popularityAscending:
            "Popularity asc"
        case .popularityDescending:
            "Popularity desc"
        case .releaseDateAscending:
            "Release date asc"
        case .releaseDateDescending:
            "Release date desc"
        }
    }
}

extension MoviesSortCategoryEntity: CaseIterable {
    public static var allCases: [MoviesSortCategoryEntity] {
        return [
            .titleAscending,
            .titleDescending,
            .popularityAscending,
            .popularityDescending,
            .releaseDateAscending,
            .releaseDateDescending
        ]
    }
    
    
}

extension MoviesSortCategoryEntity: Hashable {
    
}
