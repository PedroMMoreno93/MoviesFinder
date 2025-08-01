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

public struct SettingsView: BaseView {
    @StateObject public var viewModel: SettingsViewModel

    public init(
        viewModel: SettingsViewModel
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    public var body: some View {
        VStack {
            LaunchAtLogin.Toggle()

        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
