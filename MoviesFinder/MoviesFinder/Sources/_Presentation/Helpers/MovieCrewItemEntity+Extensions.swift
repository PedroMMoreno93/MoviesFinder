//
//  MovieCreqItemEntity+Extensions.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import UIComponents

extension MovieCrewItemEntity: Identifiable {
    public var id: String {
        name
    }
}

extension MovieCrewItemEntity: PersonCardModelView {
    public var title: String {
        return self.name
    }
    
    public var description: String {
        return self.job ?? ""
    }
    
    public var imageUrl: String? {
        return self.profilPath
    }
}
