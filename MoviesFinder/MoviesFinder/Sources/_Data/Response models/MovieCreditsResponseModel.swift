//
//  MovieCreditsResponseModel.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public struct MovieCreditsResponseModel: Codable {
    let id: Int
    let cast, crew: [CastResponseModel]
}

struct CastResponseModel: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int
    let knownForDepartment: String?
    let name: String
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}
