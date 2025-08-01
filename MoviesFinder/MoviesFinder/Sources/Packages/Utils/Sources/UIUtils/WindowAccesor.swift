//
//  WindowAccesor.swift
//  Utils
//
//  Created by Pedro M Moreno on 1/8/25.
//

import SwiftUI
import AppKit

public struct WindowAccessor: NSViewRepresentable {
    private var callback: (NSWindow) -> Void
    
    public init(
        callback: @escaping (NSWindow) -> Void
    ) {
        self.callback = callback
    }
    
    public func makeNSView(context: Context)
    -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let win = view.window { callback(win) }
        }
        return view
    }
    public func updateNSView(
        _ nsView: NSView,
        context: Context
    ) {}
}
