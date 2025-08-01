//
//  SidebarItem.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import SwiftUI

enum SidebarItem: Int, CaseIterable, Identifiable {
    case movies = 1
    case settings = 2
    
    var id: Int { rawValue }
}

extension SidebarItem {
    var title: String {
        switch self {
        case .movies:
            "Movies"
        case .settings:
            "Settings"
        }
    }
    
    var icon: Image {
        switch self {
        case .movies:
            Image(systemName: "movieclapper")
        case .settings:
            Image(systemName: "gear")
        }
    }
}
