//
//  MovieListView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//
import MVVM_Core
import SwiftUI
import Theme
import UIComponents

public struct MovieListView: BaseView {
    @StateObject public var viewModel: MovieListViewModel
    @State private var selectedDetail: MovieDetailView?
    private let createMovieDetailView: (
        Int, (() -> Void)?
    ) -> MovieDetailView

    public init(
        viewModel: MovieListViewModel,
        createMovieDetailView: @escaping (
          Int, (() -> Void)?
       ) -> MovieDetailView
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.createMovieDetailView = createMovieDetailView
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            groupedBody
            if let selectedMovieId = viewModel.modelView.selectedMovieId {
                createMovieDetailView(selectedMovieId) {
                    withAnimation {
                        viewModel.modelView.selectedMovieId = nil
                    }
                }
            }
        }
    }
    
    public var groupedBody: some View {
        Group {
            if viewModel.modelView.movies.isEmpty && viewModel.state == .success {
                emptyStateView
            } else if viewModel.state == .failure {
                errorStateView
            } else {
                content
            }
        }
        .background {
            ThemeColors.background
        }
        .overlay {
            if viewModel.state == .loading {
                LoadingView(label: viewModel.modelView.loadingStateLabel)
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }
    
    private var emptyStateView: some View {
        EmptyStateView(
            title: viewModel.modelView.emtpyStateTitle,
            description: viewModel.modelView.emptyStateDescription
        )
    }
    
    private var errorStateView: some View {
        ErrorStateView(
            title: viewModel.modelView.errorStateTitle,
            description: viewModel.modelView.errorStateDescription,
            retryButtonLabel: viewModel.modelView.errorStateRetryButtonLabel
        ) {
            Task {
                await viewModel.onAppear()
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            header
            
            if viewModel.modelView.movies.isEmpty {
                emptyStateView
            } else {
                movieList
            }
            
        }
        .padding(.horizontal, ThemeLayout.Spacing.spacingM)
        .padding(.vertical, ThemeLayout.Spacing.spacingL)
        .onChange(of: viewModel.modelView.sortBy) { _ in
            Task {
                viewModel.resetPage()
                await viewModel.fetchMovies()
            }
        }
        .onChange(of: viewModel.modelView.selectedGenre) { _ in
            Task {
                viewModel.resetPage()
                await viewModel.fetchMovies()
            }
        }
        .onChange(of: viewModel.modelView.page) { _ in
            Task {
                await viewModel.fetchMoreMovies()
            }
        }
    }
    
    private var header: some View {
        HStack {
            Spacer()
            if viewModel.state == .loading && viewModel.modelView.genres.isEmpty { // 1st time
                genreSelector
                    .redacted(reason: viewModel.modelView.genres.isEmpty ? .placeholder : .init())
            } else if !viewModel.modelView.genres.isEmpty { // already loaded
                genreSelector
            } else { // failed fetching
                EmptyView()
            }
            sortBySelector
            Spacer()
        }
    }
    
    private var genreSelector: some View {
        Picker(
            viewModel.modelView.genreDropDownTitle,
            selection: $viewModel.modelView.selectedGenre
        ) {
            ForEach(
                viewModel.modelView.genres,
                id: \.self
            ) { genre in
                Text(genre.name)
                    .onTapGesture {
                        self.viewModel.modelView.selectedGenre = genre
                    }
            }
        }
        .frame(size: ThemeLayout.Frame.pickerSize)
        .clipped()
    }
    
    private var sortBySelector: some View {
        Picker(
            viewModel.modelView.sortDropDownTitle,
            selection: $viewModel.modelView.sortBy
        ) {
            ForEach(
                MoviesSortCategoryEntity.allCases,
                id: \.self
            ) { sortCategory in
                Text(sortCategory.label)
                    .font(ThemeFonts.body)
                    .onTapGesture {
                        self.viewModel.modelView.sortBy = sortCategory
                    }
            }
        }
        .frame(size: ThemeLayout.Frame.pickerSize)
        .clipped()
    }
    
    private var moviesColumns: [GridItem] {
        return [
            GridItem(
                .adaptive(minimum: ThemeLayout.Frame.gridItemHeight),
                spacing: ThemeLayout.Spacing.spacingListRow
            )
        ]
    }
    
    private var movieList: some View {
        ScrollView {
            LazyVGrid(
                columns: moviesColumns,
                spacing: ThemeLayout.Spacing.spacingGrid
            ) {
                ForEach(viewModel.modelView.movies, id: \.id) { movie in
                    MovieCardView(model: movie) {
                        if viewModel.modelView.selectedMovieId == nil {
                            withAnimation(.easeOut(duration: 0.2)) {
                                viewModel.modelView.selectedMovieId = movie.movieId
                            }
                        } else if let selectedMovieId = viewModel.modelView.selectedMovieId,
                                  selectedMovieId != movie.movieId {
                            withAnimation(.easeOut(duration: 0.2)) {
                                viewModel.modelView.selectedMovieId = nil
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.easeOut(duration: 0.2)) {
                                    viewModel.modelView.selectedMovieId = movie.movieId
                                }
                            }
                        }
                    }
                    .redacted(reason: viewModel.state == .loading ? .placeholder : .init())
                    
                    if movie == viewModel.modelView.movies.last {
                        loadMoreCard
                    }
                }
            }
            .padding(.top)
        }
    }
    
    private var loadMoreCard: some View {
        LoadMoreCardView(label: viewModel.modelView.loadMoreLabel) {
            viewModel.nextPage()
        }
    }
}
