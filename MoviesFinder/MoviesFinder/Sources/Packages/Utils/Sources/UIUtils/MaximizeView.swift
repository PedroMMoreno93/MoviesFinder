//
//  MaximizeView.swift
//  Utils
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Foundation
import SwiftUI

public struct MaximizeView: ViewModifier {
    public init() {
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                WindowAccessor { window in
                    window.zoom(nil)
                }
            )
    }
}


public extension View {
    func maximizeView() -> some View {
        modifier(MaximizeView())
    }
}
