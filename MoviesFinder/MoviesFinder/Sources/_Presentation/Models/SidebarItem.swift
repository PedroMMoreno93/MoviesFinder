//
//  SidebarItem.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

enum SidebarItem: String, CaseIterable, Identifiable {
    case movies = "Movies"
    case settings = "Settings"
    
    var id: String { rawValue }
}

extension SidebarItem {
    var navigationTitle: String {
        switch self {
        case .movies:
            "Movies"
        case .settings:
            "Settings"
        }
    }
}
