//
//  MoviesFinderApp.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import SwiftUI
import NetworkSystem
import UIUtils

@main
struct MoviesFinderApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(
                moviesList: MovieListFactory.create()
            )
            .maximizeView()
        }
    }
}
