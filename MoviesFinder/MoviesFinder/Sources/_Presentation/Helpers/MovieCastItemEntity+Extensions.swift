//
//  MovieCastItemEntity+Extensions.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import UIComponents

extension MovieCastItemEntity: Identifiable {
    public var id: String {
        name
    }
}

extension MovieCastItemEntity: PersonCardModelView {
    public var title: String {
        return self.name
    }
    
    public var description: String {
        return self.character ?? ""
    }
    
    public var imageUrl: String? {
        return self.profilPath
    }
}
