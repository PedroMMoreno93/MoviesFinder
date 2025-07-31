//
//  RoundCornersModifier.swift
//  UIComponents
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme

public struct RoundCornersModifier: ViewModifier {
    private var cornerRadius: CGFloat
    
    public init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }
    
    public func body(content: Content) -> some View {
        content
            .clipShape(
                RoundedRectangle(
                    cornerRadius: ThemeLayout.Spacing.spacingS
                )
            )
    }
}

public extension View {
    func roundCorners(
        cornerRadius: CGFloat
    ) -> some View {
        modifier(RoundCornersModifier(cornerRadius: cornerRadius))
    }
}
