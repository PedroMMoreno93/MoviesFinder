//
//  MoviesDomainMapper.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import Foundation

open class MoviesDomainMapper {
    func map(
        responseModel: MovieListResponseModel
    ) -> [MoviesListItemEntity] {
        let mappedEntities = responseModel.results.compactMap { item in
            let backdropPathURL: String?
            
            if let backdropPath = item.backdropPath,
               !backdropPath.isEmpty {
                backdropPathURL = DataConstants.URLs.imagesBaseURL + backdropPath
            } else {
                backdropPathURL = nil
            }
            
            let posterPathURL: String?

            if let posterPath = item.posterPath,
               !posterPath.isEmpty {
                posterPathURL = DataConstants.URLs.imagesBaseURL + posterPath
            } else {
                posterPathURL = nil
            }
            
            return MoviesListItemEntity(
                adult: item.adult,
                backdropPath: backdropPathURL,
                genreIDS: item.genreIDS ?? [],
                id: item.id,
                originalLanguage: item.originalLanguage,
                originalTitle: item.originalTitle,
                overview: item.overview,
                popularity: item.popularity ?? 0,
                posterPath: posterPathURL,
                releaseDate: item.releaseDate,
                title: item.title,
                video: item.video ?? false,
                voteAverage: item.voteAverage ?? 0,
                voteCount: item.voteCount ?? 0
            )
        }
        return mappedEntities
    }
}
