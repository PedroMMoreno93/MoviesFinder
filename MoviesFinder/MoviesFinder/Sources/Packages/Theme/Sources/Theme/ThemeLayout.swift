//
//  ThemeLayout.swift
//  Theme
//
//  Created by Pedro M Moreno on 30/7/25.
//

import SwiftUI

public enum ThemeLayout {
    public enum Spacing {
        /// Tiniest components spacing. Value of 2 pt.
        public static let spacingXXS: CGFloat = 2
        
        /// Tiny gaps and close icon/text padding. Value of 4 pt.
        public static let spacingXS: CGFloat = 4
        
        /// Space between thumbnail and text in list items. Value of 8 pt.
        public static let spacingS: CGFloat = 8
        
        /// General padding inside cards and containers. Value of 16 pt.
        public static let spacingM: CGFloat = 16
        
        /// Separation between sections or genre groups. Value of 24 pt.
        public static let spacingL: CGFloat = 24
        
        /// Outer screen margins (safe area). Value of 32 pt.
        public static let spacingXL: CGFloat = 32
        
        /// Gap between columns/rows in grids. Value of 12 pt.
        public static let spacingGrid: CGFloat = 12
        
        /// Vertical spacing between list rows. Value of 20 pt.
        public static let spacingListRow: CGFloat = 20
        
        /// Vertical spacing between list rows. Value of 20 pt.
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
        /// Status bar icon frame. Value of 20 x 20.
        public static let iconStatus = CGSize(width: 20, height: 20)
        
        /// Minimum tappable area for buttons. Value of 44 x 44.
        public static let buttonMin = CGSize(width: 44, height: 44)
        
        /// Compact thumbnail in dense lists. Value of 60 x 90.
        public static let thumbnailS = CGSize(width: 60, height: 90)
        
        /// Standard thumbnail size in lists or grids. Value of 80 x 80.
        public static let thumbnailM = CGSize(width: 80, height: 80)
        
        /// Featured or highlighted thumbnail. Value of 120 x 180.
        public static let thumbnailL = CGSize(width: 120, height: 180)
                
        /// Medium icons. Value of 42 pt.
        public static let iconHeightM: CGFloat = 42

        /// Medium icons. Value of 48 pt.
        public static let iconHeightL: CGFloat = 48

        /// Larger icons. Value of 64 pt.
        public static let iconHeightXL: CGFloat = 64
        
        /// Extra large icons. Value of 100 pt.
        public static let iconHeightXXL: CGFloat = 100

                /// Fixed height for grid items. Value of 100 pt.
        public static let listRowHeight: CGFloat = 100
        
        /// Fixed height for small list rows. Value of 40 pt.
        public static let gridItemHeightS: CGFloat = 40
        
        /// Fixed height for list rows. Value of 180 pt.
        public static let gridItemHeight: CGFloat = 180
        
        /// Main poster image in detail view. Value of 200 x 300.
        public static let posterDetail = CGSize(width: 200, height: 300)
        
        /// Section banner or header image. Value of 180 pt.
        public static let backdropHeight: CGFloat = 180
        
        /// Defaul card size. Value of 180 x 20.
        public static let cardSize = CGSize(width: 180, height: 280)
        
        /// Picker style size. Value of 200 x 40.
        public static let pickerSize = CGSize(width: 200, height: 40)
        
        /// Small badges. Value of 24 pt.
        public static let badgeHeight: CGFloat = 24

        /// Side bar layout. Value of 180 pt.
        public static let sideBarWidth: CGFloat = 180

    }
}
