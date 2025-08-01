//
//  HomeView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import MVVM_Core
import SwiftUI
import UIComponents
import Theme

struct HomeView: BaseView {
    @StateObject public var viewModel: HomeViewModel
    @State private var selection: SidebarItem?
    
    let moviesList: MovieListView
    
    public init(
        viewModel: HomeViewModel = HomeViewModel(),
        moviesList: MovieListView
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.moviesList = moviesList
    }
    
    var body: some View {
        NavigationView {
            List(
                SidebarItem.allCases,
                selection: $selection
            ) { item in
                NavigationLink(destination: destination(for: item)) {
                    Label {
                        Text(item.title)
                            .font(ThemeFonts.body)
                            .foregroundStyle(ThemeColors.primaryText)
                    } icon: {
                        item.icon
                            .resizable()
                            .scaledToFit()
                            .frame(height: ThemeLayout.Frame.iconStatus.height, alignment: .center)
                            .foregroundStyle(ThemeColors.primaryText)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: ThemeLayout.Frame.sideBarWidth)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: toggleSidebar) {
                        ThemeImages.sidebarIcon
                    }
                }
            }
            
            welcomeScreen
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var welcomeScreen: some View {
        StateViewTemplate(
            title: viewModel.modelView.welcomeScreenTitle,
            description: viewModel.modelView.welcomeStringDescription
        ) {
            ThemeImages.placeholder
                .resizable()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func destination(for item: SidebarItem) -> some View {
        switch item {
        case .movies:
            self.moviesList
                .navigationTitle(item.title)
            
        case .settings:
            temporarySettingsView
                .navigationTitle(item.title)
        }
    }
    
    
    private var temporarySettingsView: some View {
        Text("To be implemented...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
