//
//  AppDelegate.swift
//  MoviesFinder
//
//  Created by Pedro M Moreno on 1/8/25.
//
import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var popover: NSPopover!
    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusBar()
        setupMainWindow()
    }
    
    private func setupMainWindow() {
        mainWindowController = MainWindowController()
        mainWindowController?.showWindow(nil)
        mainWindowController?.window?.minSize = CGSize(width: 800,
                                 height: 600)
        mainWindowController?.window?.makeKeyAndOrderFront(nil)
        mainWindowController?.window?.center()
        
        NSApp.activate(ignoringOtherApps: true)
        guard let window = NSApplication.shared.windows.first else { return }
        window.minSize = NSSize(width: 800, height: 600)
    }
    
    private func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button, let img = NSImage(named: "StatusIcon") {
            img.isTemplate = false          // si lo usas como template
            img.size = NSSize(width: 18, height: 18)
            statusItem.button?.image = img
            statusItem.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
            statusItem.button?.action = #selector(statusBarButtonClicked(_:))
            
        }
        
        popover = NSPopover()
        popover.behavior = .transient
        popover.contentSize = NSSize(width: 300, height: 400)
        popover.contentViewController = NSHostingController(
            rootView: MovieListFactory.create()
        )
    }
    
    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        guard let event = NSApp.currentEvent else { return }
        switch event.type {
        case .rightMouseUp:
            let menu = NSMenu()
            // “Open App…” abre la ventana
            menu.addItem(NSMenuItem(
                title: "Open App…",
                action: #selector(openMainWindow(_:)),
                keyEquivalent: "o"))
            // “Close Window” solo cierra la ventana
            menu.addItem(NSMenuItem(
                title: "Close Window",
                action: #selector(closeMainWindow(_:)),
                keyEquivalent: "w"))
            menu.addItem(.separator())
            // “Quit App” termina el proceso
            menu.addItem(NSMenuItem(
                title: "Quit App",
                action: #selector(quitApp(_:)),
                keyEquivalent: "q"))
            statusItem.menu = menu
            statusItem.button?.performClick(nil)
            statusItem.menu = nil

        default:
            togglePopover(sender)
        }
    }
    @objc func closeMainWindow(_ sender: Any?) {
        mainWindowController?.window?.close()
    }

    @objc func openMainWindow(_ sender: Any?) {
        mainWindowController?.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc func quitApp(_ sender: Any?) {
        NSApp.terminate(nil)
    }
    
    @objc func togglePopover(_ sender: Any?) {
        guard let button = statusItem.button else { return }
        if popover.isShown {
            popover.performClose(sender)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
}
