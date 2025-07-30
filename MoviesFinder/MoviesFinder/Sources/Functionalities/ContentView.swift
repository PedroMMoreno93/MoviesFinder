//
//  ContentView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 30/7/25.
//

import SwiftUI
import Theme

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundStyle(ThemeColors.secondaryText)
            
            Button {
                
            } label: {
                Text("Button")
            }
            .buttonStyle(.borderedProminent)
            .foregroundStyle(ThemeColors.secondaryAccent)
        }
        .padding()
        .background {
            ThemeColors.surface
        }
    }
}

#Preview {
    ContentView()
}
