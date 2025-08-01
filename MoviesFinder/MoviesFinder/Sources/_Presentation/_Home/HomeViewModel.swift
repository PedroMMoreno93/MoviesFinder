//
//  HomeViewModel.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import MVVM_Core

public class HomeViewModel: BaseViewModel {
    @Published public var modelView: HomeModelView
    @Published public var state: ViewModelState
    
    public init(
        modelView: HomeModelView = HomeModelView(),
        state: ViewModelState = .initial
    ) {
        self.modelView = modelView
        self.state = state
    }
}
