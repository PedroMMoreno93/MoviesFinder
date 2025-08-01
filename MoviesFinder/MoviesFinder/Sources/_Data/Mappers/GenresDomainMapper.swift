//
//  GenresDomainMapper.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

open class GenresDomainMapper {
    func map(
        responseModel: GenresListResponseModel
    ) -> [GenreEntity] {
        let mappedEntities = responseModel.genres.compactMap { item in
            if let id = item.id,
               let name = item.name {
                return GenreEntity(id: id, name: name)
            } else {
                return nil
            }
        }
        return mappedEntities
    }
    
    func mapGenresIds(
        _ genres: [GenreEntity]
    ) -> [String] {
        return genres.compactMap { genre in
            return "\(genre.id)"
        }
    }
}
