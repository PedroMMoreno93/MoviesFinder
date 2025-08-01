//
//  MovieCreditsDomainMapper.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

open class MovieCreditsDomainMapper {
    func map(
        responseModel: MovieCreditsResponseModel
    ) -> MovieCreditsEntity {
        
        let mappedCastEntities = responseModel.cast.compactMap { castMember in
            let profilePathURL: String?
            if let profilePath = castMember.profilePath,
               !profilePath.isEmpty {
                profilePathURL = DataConstants.URLs.imagesBaseURL + profilePath
            } else {
                profilePathURL = nil
            }
            
           return MovieCastItemEntity(
                name: castMember.name,
                profilPath: profilePathURL,
                character: castMember.character
            )
        }
        
        let mappedCrewEntities = responseModel.crew.compactMap { crewMember in
            let profilePathURL: String?
            if let profilePath = crewMember.profilePath,
               !profilePath.isEmpty {
                profilePathURL = DataConstants.URLs.imagesBaseURL + profilePath
            } else {
                profilePathURL = nil
            }
            
            return MovieCrewItemEntity(
                name: crewMember.name,
                profilPath: profilePathURL,
                job: crewMember.job
            )
        }
        
        
        let mappedEntity = MovieCreditsEntity(
            cast: mappedCastEntities,
            crew: mappedCrewEntities
        )
        
        return mappedEntity
    }
}
