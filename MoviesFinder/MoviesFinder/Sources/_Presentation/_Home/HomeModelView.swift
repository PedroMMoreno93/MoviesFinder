//
//  HomeModelView.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import MVVM_Core

public struct HomeModelView: BaseModelView {
    let welcomeScreenTitle: String = "Welcome to Movies Finder"
    let welcomeStringDescription: String = """
Here you can sort and your favourite movies.
Click on Movies and start enjoying!
"""
    
    public init() {
        
    }
}
