//
//  LoadMoreCardView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme

public struct LoadMoreCardView: View {
    private var label: String
    private var onTapped: () -> Void
    
    public init(
        label: String,
        onTapped: @escaping () -> Void
    ) {
        self.label = label
        self.onTapped = onTapped
    }
    
    public var body: some View {
        VStack(
            alignment: .center,
            spacing: ThemeLayout.Spacing.spacingS
        ) {
            image
            labelView
            .padding(.horizontal, ThemeLayout.Spacing.spacingM)
            .padding(.bottom, ThemeLayout.Spacing.spacingM)
        }
        .customCardStyle()
        .onTapGesture {
            self.onTapped()
        }
    }
 
    private var image: some View {
        ThemeImages.more
            .resizable()
            .scaledToFit()
            .frame(height: ThemeLayout.Frame.iconHeightM)
            .foregroundStyle(ThemeColors.secondaryAccent)
    }
    
    private var labelView: some View {
        Text(label)
            .font(ThemeFonts.title)
            .foregroundStyle(ThemeColors.secondaryAccent)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    LoadMoreCardView(label: "Load More") {
        
    }
}
