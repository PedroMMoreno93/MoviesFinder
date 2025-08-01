//
//  GenresListResponseModel.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation

public struct GenresListResponseModel: Codable {
    let genres: [GenresListItemResponseModel]
}

public struct GenresListItemResponseModel: Codable {
    let id: Int?
    let name: String?
}
