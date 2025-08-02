//
//  BaseViewModel.swift
//  MVVM_Core
//
//  Created by Pedro M Moreno on 30/7/25.
//
import SwiftUI

public protocol BaseViewModel: ObservableObject {
    associatedtype ModelView: BaseModelView
    
    var modelView: ModelView { get set }
    var state: ViewModelState { get set }
}
