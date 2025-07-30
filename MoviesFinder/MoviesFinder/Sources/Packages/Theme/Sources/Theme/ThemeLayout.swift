//
//  ThemeLayout.swift
//  Theme
//
//  Created by Pedro M Moreno on 30/7/25.
//

import SwiftUI

public enum ThemeLayout {
    public enum Spacing {
        /// Tiny gaps and close icon/text padding
        public static let spacingXS: CGFloat = 4
        
        /// Space between thumbnail and text in list items
        public static let spacingS: CGFloat = 8
        
        /// General padding inside cards and containers
        public static let spacingM: CGFloat = 16
        
        /// Separation between sections or genre groups
        public static let spacingL: CGFloat = 24
        
        /// Outer screen margins (safe area)
        public static let spacingXL: CGFloat = 32
        
        /// Gap between columns/rows in grids
        public static let spacingGrid: CGFloat = 12
        
        /// Vertical spacing between list rows
        public static let spacingListRow: CGFloat = 20
        
        /// Vertical spacing between list rows
        public static let spacingSection: CGFloat = 20
        
        
        /// Returns the vertical padding amount for section headers based on the given density.
        /// - Parameter density: The density level determining how much vertical space to apply.
        /// - Returns: A `CGFloat` representing the vertical inset (in points).
        ///
        /// Usage:
        /// ```swift
        /// // Choose your desired density
        /// let insetValue = inset(for: .regular)  // 20 pt
        ///
        /// // Apply to a SwiftUI view:
        /// Text("Comedy Section")
        ///     .padding(.vertical, insetValue)
        /// ```
        public static func inset(
            for density: SectionDensity
        ) -> CGFloat {
            switch density {
            case .compact:
                return Spacing.spacingM
            case .regular:
                return (Spacing.spacingM + Spacing.spacingL) / 2
            case .spacious:
                return Spacing.spacingL
            }
        }
        
    }
    
    /// Defines density levels for section insets.
    /// - compact: A tighter inset (16 pt).
    /// - regular: A balanced inset (20 pt).
    /// - spacious: A more generous inset (24 pt).
    public enum SectionDensity {
        /// 16 pt
        case compact
        /// 20 pt
        case regular
        // 24 pt
        case spacious
    }
    
    public enum Frame {
        /// Status bar icon frame
        static let iconStatus = CGSize(width: 20,  height: 20)
        
        /// Minimum tappable area for buttons
        static let buttonMin = CGSize(width: 44,  height: 44)
        
        /// Compact thumbnail in dense lists
        static let thumbnailSmall = CGSize(width: 60,  height: 90)
        
        /// Standard thumbnail size in lists or grids
        static let thumbnailMed = CGSize(width: 80,  height: 120)
        
        /// Featured or highlighted thumbnail
        static let thumbnailLarge = CGSize(width: 120, height: 180)
        
        /// Fixed height for grid items
        static let listRowHeight: CGFloat = 100
        
        /// Fixed height for list rows
        static let gridItemHeight: CGFloat = 150
        
        /// Main poster image in detail view
        static let posterDetail = CGSize(width: 200, height: 300)
        
        /// Section banner or header image
        static let backdropHeight: CGFloat = 180
    }
}
