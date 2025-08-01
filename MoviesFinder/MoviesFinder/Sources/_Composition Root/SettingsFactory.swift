//
//  SettingsFactory.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation

public enum SettingsFactory {
   public static func create() -> SettingsView {
        return SettingsView(
            viewModel: createViewModel()
        )
    }
    
    private static func createViewModel() -> SettingsViewModel {
        return SettingsViewModel()
    }
}
