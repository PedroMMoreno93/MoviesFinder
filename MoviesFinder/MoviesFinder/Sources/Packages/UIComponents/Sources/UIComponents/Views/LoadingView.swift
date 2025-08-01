//
//  LoadingView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI
import Theme

public struct LoadingView: View {
    private let label: String
    
    public init(
        label: String
    ) {
        self.label = label
    }
    
    public var body: some View {
        ZStack {
            ThemeColors.shadow.opacity(0.6)
                .opacity(0.5)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity
                )
            VStack(spacing: 16) {
                spinner
                    .scaleEffect(1.4)
                
                Text(label)
                    .font(ThemeFonts.headline)
                    .foregroundColor(.primary)
            }

        }
    }
    
    var spinner: some View {
        Spinner()
    }
}

#Preview {
    LoadingView(label: "Loading...")
}
