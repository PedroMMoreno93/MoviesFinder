//
//  Spinner.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme

public struct Spinner: View {
    @State private var rotationAngle: Double = 0.0
    private let colors: [Color] = [
        ThemeColors.primaryText,
        ThemeColors.primaryText.opacity(0.3)
    ]
    
    private let ringRadius: CGFloat = ThemeLayout.Frame.iconStatus.width
    private let minRotationAngle: Double = 0
    private let maxRotationAngle: Double = 360.0
    private let indicatorRatio: Double = 0.1
    private let indicatorOffsetRatio: Double = 0.5
    
    public init() {
    }
    
    public var body: some View {
        ZStack(
            alignment: .center
        ) {
            circle
            indicator
        }
        .rotationEffect(.degrees(rotationAngle))
        .onAppear {
            withAnimation(
                .linear(duration: 1.5)
                .repeatForever(autoreverses: false)
            ) {
                rotationAngle = maxRotationAngle
            }
        }
        .onDisappear {
            rotationAngle = minRotationAngle
        }
    }
    
    private var circle: some View {
        Circle()
            .stroke(
                AngularGradient(
                    gradient: Gradient(colors: colors),
                    center: .center,
                    startAngle: .degrees(minRotationAngle),
                    endAngle: .degrees(maxRotationAngle)
                ),
                style: StrokeStyle(
                    lineWidth: ringRadius * indicatorRatio,
                    lineCap: .round
                )
            )
            .frame(width: ringRadius, height: ringRadius)
    }
    
    private var indicator: some View {
        Circle()
            .frame(
                width: ringRadius * indicatorRatio,
                height: ringRadius * indicatorRatio
            )
            .foregroundColor(ThemeColors.primaryText)
            .offset(x: ringRadius * indicatorOffsetRatio)
    }
}

#Preview {
    Spinner()
}
