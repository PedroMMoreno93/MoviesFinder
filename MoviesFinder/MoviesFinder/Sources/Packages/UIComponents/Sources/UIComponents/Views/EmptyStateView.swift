//
//  EmptyStateView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme
import UIUtils

public struct EmptyStateView: View {
    private let title: String
    private let description: String
    private let retryButtonLabel: String?
    private let retryButtonAction: (() -> Void)?
    
    public init(
        title: String,
        description: String,
        retryButtonLabel: String? = nil,
        retryButtonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.description = description
        self.retryButtonLabel = retryButtonLabel
        self.retryButtonAction = retryButtonAction
    }
    
    public var body: some View {
        StateViewTemplate(
            title: title,
            description: description,
            retryButtonLabel: retryButtonLabel,
            retryButtonAction: retryButtonAction
        ) {
            icon
        }
    }
    
    private var icon: some View {
        ThemeImages.placeholder
            .resizable()
            .scaledToFit()
            .frame(size: ThemeLayout.Frame.thumbnailM)
    }
}

#Preview {
    EmptyStateView(
        title: "No movies to display",
        description: "Select another genre or change sort category.",
        retryButtonLabel: "Retry"
    ) {
        
    }
}
