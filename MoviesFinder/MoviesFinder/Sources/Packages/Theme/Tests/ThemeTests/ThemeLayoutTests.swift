//
//  ThemeLayoutTests.swift
//  Theme
//
//  Created by Pedro M Moreno on 30/7/25.
//

import XCTest
@testable import Theme

final class ThemeLayoutTests: XCTestCase {

    func testInsetCompact() throws {
        let expectation = ThemeLayout.Spacing.spacingM
        
        let result = ThemeLayout.Spacing.inset(
            for: .compact
        )
        XCTAssertEqual(expectation, result)
    }
    
    func testInsetRegular() throws {
        let expectation = (ThemeLayout.Spacing.spacingM + ThemeLayout.Spacing.spacingL) / 2
        
        let result = ThemeLayout.Spacing.inset(
            for: .regular
        )
        XCTAssertEqual(expectation, result)
    }
    
    func testInsetSpacious() throws {
        let expectation = ThemeLayout.Spacing.spacingL
        
        let result = ThemeLayout.Spacing.inset(
            for: .spacious
        )
        XCTAssertEqual(expectation, result)
    }

}
