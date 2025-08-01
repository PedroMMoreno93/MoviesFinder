//
//  StateViewTemplate.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme
import UIUtils

public struct StateViewTemplate<Icon: View>: View {
    private let title: String
    private let description: String
    private let retryButtonLabel: String?
    private let retryButtonAction: (() -> Void)?
    private let icon: Icon
    
    public init(
        title: String,
        description: String,
        retryButtonLabel: String? = nil,
        retryButtonAction: (() -> Void)? = nil,
        @ViewBuilder icon: @escaping () -> Icon
    ) {
        self.title = title
        self.description = description
        self.retryButtonLabel = retryButtonLabel
        self.icon = icon()
        self.retryButtonAction = retryButtonAction
    }
    
    public var body: some View {
        VStack(
            alignment: .center,
            spacing: ThemeLayout.Spacing.spacingL
        ) {
            image
            titleView
            descriptionView
            retryButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ThemeColors.background)
    }
    
    private var image: some View {
        icon
            .frame(size: ThemeLayout.Frame.thumbnailM)
    }
    
    private var titleView: some View {
        Text(title)
            .font(ThemeFonts.title)
            .foregroundColor(ThemeColors.primaryText)
    }
    
    private var descriptionView: some View {
        Text(description)
            .font(ThemeFonts.body)
            .foregroundColor(ThemeColors.secondaryText)
            .multilineTextAlignment(.center)
            .padding(.horizontal, ThemeLayout.Spacing.spacingM)
    }
    
    @ViewBuilder private var retryButton: some View {
        if let retryButtonLabel = retryButtonLabel,
           let retryButtonAction = retryButtonAction {
            Button(action: retryButtonAction) {
                Text(retryButtonLabel)
                    .font(ThemeFonts.headline)
                    .padding(.horizontal, ThemeLayout.Spacing.spacingL)
                    .padding(.vertical, ThemeLayout.Spacing.spacingS)
            }
            .buttonStyle(.borderedProminent)
            .tint(ThemeColors.primaryAccent)
            .padding(.top, ThemeLayout.Spacing.spacingM)
        }
    }
}
