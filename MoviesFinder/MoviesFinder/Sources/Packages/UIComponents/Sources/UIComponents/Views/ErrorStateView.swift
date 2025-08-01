//
//  ErrorStateView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme

public struct ErrorStateView: View {
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
        ThemeImages.warinng
            .resizable()
            .scaledToFit()
            .frame(size: ThemeLayout.Frame.thumbnailM)
            .foregroundStyle(ThemeColors.error)
    }
}

#Preview {
    ErrorStateView(
        title: "Something went wrong",
        description: "Couldn't load images.",
        retryButtonLabel: "Retry"
    ) {
        
    }
}
