//
//  SettingsViewModel.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import MVVM_Core
import SwiftUI

public class SettingsViewModel: BaseViewModel {
    @Published public var modelView: SettingsModelView
    @Published public var state: ViewModelState
    
    public init(
        modelView: SettingsModelView = SettingsModelView(),
        state: ViewModelState = .initial
    ) {
        self.modelView = modelView
        self.state = state
    }
}
