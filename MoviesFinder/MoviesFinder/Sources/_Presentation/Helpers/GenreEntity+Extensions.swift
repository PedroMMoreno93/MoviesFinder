//
//  GenreEntity+Extensions.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import Foundation

extension GenreEntity {
    public static let all = GenreEntity(id: 0, name: "All")
}

extension GenreEntity: Hashable {
    public static func == (lhs: GenreEntity, rhs: GenreEntity) -> Bool {
          return lhs.id == rhs.id &&
                 lhs.name == rhs.name
      }

    public func hash(into hasher: inout Hasher) {
          hasher.combine(id)
          hasher.combine(name)
      }
}
