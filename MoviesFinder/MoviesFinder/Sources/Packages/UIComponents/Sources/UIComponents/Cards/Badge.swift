//
//  Badge.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme

public struct Badge: View {
    private let label: String
    private let foregroundColor: Color
    private let backgoundColor: Color
    
    public init(
        label: String,
        foregroundColor: Color = ThemeColors.primaryText,
        backgoundColor: Color = ThemeColors.highlight
    ) {
        self.label = label
        self.foregroundColor = foregroundColor
        self.backgoundColor = backgoundColor
    }
    
    public var body: some View {
        Text(label)
            .font(ThemeFonts.caption)
            .foregroundStyle(foregroundColor)
            .lineLimit(1)
            .padding(.vertical, ThemeLayout.Spacing.spacingXXS)
            .padding(.horizontal, ThemeLayout.Spacing.spacingS)
            .background {
                backgoundColor
            }
            .roundCorners(cornerRadius: ThemeLayout.Spacing.spacingXS)
    }
}

#Preview {
    Badge(label: "Action")
}
