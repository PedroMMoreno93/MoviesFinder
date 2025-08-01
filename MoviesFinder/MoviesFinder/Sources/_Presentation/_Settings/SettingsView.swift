//
//  SettingsView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import LaunchAtLogin
import MVVM_Core
import SwiftUI
import Theme

public struct SettingsView: BaseView {
    @AppStorage("appearance")
    private var selectedAppearance: Appearance = .system
    @StateObject public var viewModel: SettingsViewModel
    
    public init(
        viewModel: SettingsViewModel
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    public var body: some View {
        VStack(
            alignment: .leading,
            spacing: ThemeLayout.Spacing.spacingXL
        ) {
            launchAtLogin
            appearance
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var launchAtLogin: some View {
        LaunchAtLogin.Toggle()
        
    }
    
    private var appearance: some View {
        Picker(viewModel.modelView.appearanceSelectorLabel, selection: $selectedAppearance) {
            ForEach(Appearance.allCases) { mode in
                Text(mode.rawValue).tag(mode)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(size: ThemeLayout.Frame.pickeraSizeL)
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
