//
//  MoviesSortCategoryMapper.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

open class MoviesSortCategoryDomainMapper {
    func map(
        entity: MoviesSortCategoryEntity
    ) -> String {
        return switch entity {
        case .titleAscending:
            "title.asc"
            
        case .titleDescending:
            "title.desc"
            
        case .popularityAscending:
            "popularity.asc"
            
        case .popularityDescending:
            "popularity.desc"
            
        case .releaseDateAscending:
            "primaryReleaseDate.asc"
            
        case .releaseDateDescending:
            "secondaryReleaseDate.desc"
        }
    }
}
