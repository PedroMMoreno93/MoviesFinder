//
//  MovieDetailView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import MVVM_Core
import SwiftUI
import Theme
import UIComponents

public struct MovieDetailView: BaseView {
    @StateObject public var viewModel: MovieDetailViewModel
    var backButtonAction: (() -> Void)?
    
    public init(
        viewModel: MovieDetailViewModel,
        backButtonAction: (() -> Void)?
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.backButtonAction = backButtonAction
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                image
                    .overlay {
                        overlay
                            .padding()
                    }
                VStack {
                    overview
                    characters
                    crew
                }
                .padding(.horizontal)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .overlay {
            if viewModel.state == .loading {
                LoadingView(label: viewModel.modelView.loadingStateLabel)
            }
        }
        .background {
            ThemeColors.background
        }
        .alert(
            viewModel.modelView.errorAlertTitle,
            isPresented: $viewModel.showAlert
        ) {
            Button(viewModel.modelView.errorAlertButtonLabel) {
                if let backButtonAction = backButtonAction {
                    backButtonAction()
                }
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }
    
    private var overlay: some View {
        VStack(
            alignment: .leading,
            spacing: ThemeLayout.Spacing.spacingL
        ) {
            backButton
            Spacer()
            titleHeader
                .frame(maxWidth: .infinity, alignment: .leading)
            dateAndCountry
            genres
        }
        .frame(maxWidth: .infinity)
    }
    
    private var overview: some View {
        VStack(
            alignment: .leading,
            spacing: ThemeLayout.Spacing.spacingL
        ) {
            Text(viewModel.modelView.overViewTitle)
                .foregroundStyle(ThemeColors.primaryText)
                .font(ThemeFonts.display)
            
            Text(viewModel.modelView.details.overview)
                .foregroundStyle(ThemeColors.primaryText)
                .font(ThemeFonts.body)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var characters: some View {
        VStack(alignment: .leading) {
            Text(viewModel.modelView.castTitle)
                .foregroundStyle(ThemeColors.primaryText)
                .font(ThemeFonts.display)
            
            ScrollView(.horizontal) {
                HStack(alignment: .bottom) {
                    ForEach(viewModel.modelView.credits.cast, id: \.id
                    ) { castMember in
                        PersonCardView(model: castMember)
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var crew: some View {
        VStack(alignment: .leading) {
            Text(viewModel.modelView.crewTitle)
                .foregroundStyle(ThemeColors.primaryText)
                .font(ThemeFonts.display)
            
            ScrollView(.horizontal) {
                HStack(alignment: .bottom) {
                    ForEach(viewModel.modelView.credits.crew, id: \.id
                    ) { crewMember in
                        PersonCardView(model: crewMember)
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var titleHeader: some View {
        HStack {
            Text(viewModel.modelView.details.title)
                .foregroundStyle(ThemeColors.primaryText)
                .font(ThemeFonts.display)
            
            if let language = viewModel.modelView.details.language {
                Badge(
                    label: language.uppercased(),
                    foregroundColor: ThemeColors.primaryText,
                    backgoundColor: ThemeColors.secondaryAccent
                )
            }
        }
    }
    
    private var dateAndCountry: some View {
        HStack {
            if let releaseDate = viewModel.modelView.details.releaseDate {
                Text(releaseDate)
                    .foregroundStyle(ThemeColors.primaryText)
                    .font(ThemeFonts.body)
            }
            
            Badge(
                label: viewModel.modelView.details.country.uppercased(),
                foregroundColor: ThemeColors.background,
                backgoundColor: ThemeColors.shadow
            )
        }
    }
    
    @ViewBuilder private var genres: some View {
        if !viewModel.modelView.details.genres.isEmpty {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.modelView.details.genres, id: \.self) { genre in
                        Badge(label: genre.name)
                    }
                }
            }
        }
        
    }
    
    @ViewBuilder private var releaseDate: some View {
        if let releaseDate = viewModel.modelView.details.releaseDate {
            Text(releaseDate)
                .font(ThemeFonts.body)
                .foregroundStyle(ThemeColors.primaryText)
        }
    }
    
    private var backButton: some View {
        Button {
            if let backButtonAction = backButtonAction {
                backButtonAction()
            }
        } label: {
            ThemeImages.backIcon
                .foregroundStyle(ThemeColors.primaryText)
        }
        .buttonStyle(.borderedProminent)
        .tint(ThemeColors.primaryAccent)
    }
    
    @ViewBuilder private var image: some View {
        if let backdropPath = viewModel.modelView.details.backdropPath {
            AsyncImage(
                url: URL(string: backdropPath)
            ) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .opacity(0.6)
                    .blur(radius: 1)
                    
            } placeholder: {
                ZStack {
                    ThemeColors.background
                        .frame(maxWidth: .infinity)
                        .frame(height: ThemeLayout.Frame.detailBackdropHeight)
                    
                    Spinner()
                        .frame(height: ThemeLayout.Frame.iconHeightXL)
                }
                .frame(maxWidth: .infinity)
                .frame(height: ThemeLayout.Frame.detailBackdropHeight)
                .opacity(0.4)
            }
        } else {
            ZStack {
                ThemeColors.background
                    .frame(maxWidth: .infinity)
                    .frame(height: ThemeLayout.Frame.detailBackdropHeight)

                ThemeImages.placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(height: ThemeLayout.Frame.iconHeightXL)
            }
            .frame(maxWidth: .infinity)
            .frame(height: ThemeLayout.Frame.detailBackdropHeight)
            .opacity(0.4)
        }
    }
}
