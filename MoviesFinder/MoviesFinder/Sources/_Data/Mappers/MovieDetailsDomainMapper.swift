//
//  MovieDetailsDomainMapper.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import Utils

open class MovieDetailsDomainMapper {
    func map(
        responseModel: MovieDetailsResponseModel
    ) -> MovieDetailsEntity {

        let backdropPathURL: String?
        
        if let backdropPath = responseModel.backdropPath,
           !backdropPath.isEmpty {
            backdropPathURL = DataConstants.URLs.imagesBaseURL + backdropPath
        } else {
            backdropPathURL = nil
        }
        
        let country = responseModel.originCountry?.first ?? ""
        
        let formattedDate: String?
        if let releaseDate = responseModel.releaseDate,
           let date = releaseDate.toDate(format: "yyyy-MM-dd") {
            formattedDate = date.toString(format: "dd/MM/yyyy")
        } else {
            formattedDate = nil
        }
        let genresEntities: [GenreEntity]
        
        if let genres = responseModel.genres,
          !genres.isEmpty {
            genresEntities = genres.compactMap { genreResponseModel in
                if let id = genreResponseModel.id,
                   let name = genreResponseModel.name {
                   return GenreEntity(id: id, name: name)
                } else {
                    return nil
                }
            }
        } else {
            genresEntities = []
        }
        
        let mappedEntity = MovieDetailsEntity(
            title: responseModel.title,
            overview: responseModel.overview,
            language: responseModel.originalLanguage,
            backdropPath: backdropPathURL,
            country: country,
            releaseDate: formattedDate,
            genres: genresEntities
        )
        
        return mappedEntity
    }
}
