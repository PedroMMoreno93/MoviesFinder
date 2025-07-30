//
//  ThemeFonts.swift
//  Theme
//
//  Created by Pedro M Moreno on 30/7/25.
//

import SwiftUI

public enum ThemeFonts {
    /// Primary screen headers and main titles
    public static let display = Font.system(.largeTitle).weight(.semibold)
    
    /// Section headings in lists or panels
    public static let title = Font.system(.title2).weight(.semibold)
    
    /// Titles in list items
    public static let headline = Font.system(.headline).weight(.semibold)
    
    /// Paragraph text such as synopses
    public static let body = Font.system(.body).weight(.regular)
    
    /// Secondary text under headlines (dates, ratings)
    public static let subhead = Font.system(.subheadline).weight(.regular)
    
    /// Small labels, timestamps, credits
    public static let caption = Font.system(.caption).weight(.regular)
    
    /// Copyright notes, disclaimers
    public static let footnote = Font.system(.footnote).weight(.regular)
}
