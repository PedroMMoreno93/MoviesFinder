//
//  BaseView.swift
//  MVVM_Core
//
//  Created by Pedro M Moreno on 30/7/25.
//

import SwiftUI

public protocol BaseView: View {
    associatedtype ViewModel: BaseViewModel
    
    var viewModel: ViewModel { get set }
}
