//
//  CustomShadowModifier.swift
//  UIComponents
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme

public struct CustomShadowModifier: ViewModifier {
    private var isHovering: Bool

    public init(isHovering: Bool) {
        self.isHovering = isHovering
    }
    
    public func body(content: Content) -> some View {
        content
            .shadow(
                color: ThemeColors.shadow.opacity(0.1),
                radius: isHovering ?
                ThemeLayout.Spacing.spacingXS
                : ThemeLayout.Spacing.spacingXXS,
                x: 0,
                y: ThemeLayout.Spacing.spacingXXS
            )
    }
}

public extension View {
    func customShadow(
        isHovering: Bool
    ) -> some View {
      modifier(CustomShadowModifier(isHovering: isHovering))
    }
}
