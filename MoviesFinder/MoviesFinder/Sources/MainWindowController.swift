//
//  MainWindowController.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//

import Cocoa
import SwiftUI

class MainWindowController: NSWindowController {
    convenience init() {
        let homeView = HomeView(
            moviesList: MovieListFactory.create()
        )
        .maximizeView()
        
        let contentView = NSHostingView(
            rootView: homeView
        )
        
        let screenFrame = NSScreen.main?.frame ?? NSRect(x: 0, y: 0, width: 800, height: 600)
        contentView.window?.minSize = NSSize(width: 800, height: 600)
        
        let window = NSWindow(
            contentRect: screenFrame,
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false)
        window.contentView = contentView
        window.title = "MoviesFinder"
        window.minSize = NSSize(width: 800, height: 600)
        self.init(window: window)
    }
    
    override func windowDidLoad() {
           super.windowDidLoad()
           
           window?.minSize = CGSize(width: 800,
                                    height: 600)
           window?.makeKeyAndOrderFront(nil)
           window?.center()
       }
}
