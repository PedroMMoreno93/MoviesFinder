//
//  FrameSize.swift
//  Utils
//
//  Created by Pedro M Moreno on 31/7/25.
//

import SwiftUI

public struct FrameSize: ViewModifier {
    private let size: CGSize
    
    public init(size: CGSize) {
        self.size = size
    }
    
    public func body(content: Content) -> some View {
        content
            .frame(
                width: size.width,
                height: size.height
            )
    }
}

public extension View {
    func frame(
        size: CGSize
    ) -> some View {
      modifier(FrameSize(size: size))
    }
}
