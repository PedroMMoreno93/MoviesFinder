//
//  MoviewCardView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import SwiftUI
import Theme

public protocol MoviewCardModelView: Identifiable, Equatable {
    var title: String { get }
    var description: String { get }
    var badges: [String] { get }
    var thumbnailUrl: String? { get }
}

public struct MoviewCardView: View {
    private let model: any MoviewCardModelView
    private var onTapped: () -> Void

    public init(
        model: any MoviewCardModelView,
        onTapped: @escaping () -> Void
    ) {
        self.model = model
        self.onTapped = onTapped
    }
    
    public var body: some View {
        VStack(
            alignment: .center,
            spacing: ThemeLayout.Spacing.spacingS
        ) {
            image

            VStack(
                alignment: .leading,
                spacing: ThemeLayout.Spacing.spacingS
            ) {
                info
                
                badges
                    .frame(
                        width: ThemeLayout.Frame.gridItemHeight - ThemeLayout.Spacing.spacingM,
                        height: ThemeLayout.Frame.iconHeightL,
                        alignment: .top
                    )
            }
            .padding(.horizontal, ThemeLayout.Spacing.spacingM)
            .padding(.bottom, ThemeLayout.Spacing.spacingM)
        }
        .customCardStyle()
        .onTapGesture {
            self.onTapped()
        }
    }
 
    @ViewBuilder private var image: some View {
        if let backdropPath = model.thumbnailUrl {
            AsyncImage(
                url: URL(string: backdropPath)
            ) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: ThemeLayout.Frame.cardSize.width)
            } placeholder: {
                Spinner()
                    .frame(height: ThemeLayout.Frame.iconHeightXXL)
            }
        } else {
            ZStack {
                ThemeColors.background
                ThemeImages.placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(height: ThemeLayout.Frame.iconHeightXL)
            }
            .frame(height: ThemeLayout.Frame.iconHeightXXL)
        }
    }
    
    private var info: some View {
        VStack(
            alignment: .leading,
            spacing: ThemeLayout.Spacing.spacingXS
        ) {
            Text(model.title)
                .font(ThemeFonts.headline)
                .foregroundStyle(ThemeColors.primaryText)
                .lineLimit(2)
            
            Text(model.description)
                .font(ThemeFonts.body)
                .foregroundStyle(ThemeColors.secondaryText)
                .lineLimit(3)
        }
        .frame(height: ThemeLayout.Frame.iconHeightXXL, alignment: .top)
    }
    
    @ViewBuilder private var badges: some View {
        if !model.badges.isEmpty {
            LazyVGrid(
                columns: [
                    GridItem(
                        .adaptive(
                            minimum: ThemeLayout.Frame.gridItemHeightS
                        ),
                        spacing: ThemeLayout.Spacing.spacingXS,
                        alignment: .topLeading
                    )
                ],
                spacing: ThemeLayout.Spacing.spacingXS,
            ) {
                ForEach(model.badges, id: \.self) { badge in
                    Badge(label: badge)
                        .frame(
                            height: ThemeLayout.Frame.badgeHeight,
                            alignment: .top
                        )
                }
            }
        } else {
            Color.clear
               
        }
    }
}
