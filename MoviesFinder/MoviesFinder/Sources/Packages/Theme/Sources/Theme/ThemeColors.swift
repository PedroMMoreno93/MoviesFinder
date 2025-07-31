//
//  ThemeColors.swift
//  Theme
//
//  Created by Pedro M Moreno on 30/7/25.
//

import SwiftUI

public enum ThemeColors {
    /// Main window or screen background
    public static let background = Color("Background", bundle: .module)
    
    /// Panels, cards and dropdown/menu backgrounds
    public static let surface = Color("Surface", bundle: .module)
    
    /// Elements shadows
    public static let shadow = Color("Shadow", bundle: .module)
    
    /// Main body text, headlines
    public static let primaryText = Color("Primary Text", bundle: .module)
    
    /// Subheaders, placeholder text and less-prominent labels
    public static let secondaryText = Color("Secondary Text", bundle: .module)
    
    /// Primary buttons, links and call‑to‑action elements
    public static let primaryAccent = Color("Primary Accent", bundle: .module)
    
    /// Subtle highlights, secondary icons and less‑dominant accents
    public static let secondaryAccent = Color("Secondary Accent", bundle: .module)
    
    /// Informational badges, tags or light emphasis
    public static let highlight = Color("Highlight", bundle: .module)
    
    /// Thin separators and borders between sections
    public static let borderDivider = Color("borderDivider", bundle: .module)
    
    /// Error messages, destructive actions and alerts
    public static let error = Color("Error", bundle: .module)
    
    /// Success indicators, confirmations and “OK” states
    public static let success = Color("Success", bundle: .module)
    
    /// Warnings and cautionary states
    public static let warning = Color("Warning", bundle: .module)
}
