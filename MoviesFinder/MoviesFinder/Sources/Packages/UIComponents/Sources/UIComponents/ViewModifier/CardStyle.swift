//
//  CardStyle.swift
//  UIComponents
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme
import UIUtils

public struct CardStyle: ViewModifier {
    @State private var isHovering: Bool = false

    private let cardSize: CGSize
    private let backgroundColor: Color
    private let overlayColor: Color
    
    public init(
        cardSize: CGSize = ThemeLayout.Frame.cardSize,
        backgroundColor: Color = ThemeColors.surface,
        overlayColor: Color = ThemeColors.primaryAccent
    ) {
        self.cardSize = cardSize
        self.backgroundColor = backgroundColor
        self.overlayColor = overlayColor
    }
    
    public func body(content: Content) -> some View {
        content
            .frame(
                size: cardSize
            )
            .background {
                ThemeColors.surface
            }
            .roundCorners(
                cornerRadius: ThemeLayout.Spacing.spacingS
            )
            .customShadow(
                isHovering: isHovering
            )
            .onHover { isHovering in
                withAnimation {
                    self.isHovering = isHovering
                }
            }
            .scaleEffect(isHovering ? 1.04 : 1)
    }
}

public extension View {
    func customCardStyle(
        cardSize: CGSize = ThemeLayout.Frame.cardSize,
        backgroundColor: Color = ThemeColors.surface,
        overlayColor: Color = ThemeColors.primaryAccent
    ) -> some View {
        modifier(
            CardStyle(
                cardSize: cardSize,
                backgroundColor: backgroundColor,
                overlayColor: overlayColor
            )
        )
    }
}
