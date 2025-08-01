//
//  GenreEntityHashableTests.swift
//  MoviesFinderTests
//
//  Created by Pedro M Moreno on 31/7/25.
//

import XCTest
@testable import MoviesFinder

final class GenreEntityHashableTests: XCTestCase {
    
    func test_equal_instances_have_equal_hash() {
        // GIVEN
        let firstMock = GenreEntity(id: 16, name: "Animation")
        let secondMock = GenreEntity(id: 16, name: "Animation")
        
        // THEN
        XCTAssertEqual(
            firstMock,
            secondMock,
            "Instances with identical properties should be equal (==)."
        )
        XCTAssertEqual(
            firstMock.hashValue,
            secondMock.hashValue,
            "Equal instances must produce the same hashValue."
        )
    }
    
    func test_different_instances_have_different_hash() {
        // GIVEN
        let firstMock = GenreEntity(id: 16, name: "Animation")
        let secondMock = GenreEntity(id: 35, name: "Comedy")
        
        // THEN
        XCTAssertNotEqual(
            firstMock,
            secondMock,
            "Instances with different IDs should not be equal (!=)."
        )
        XCTAssertNotEqual(
            firstMock.hashValue,
            secondMock.hashValue,
            "Different instances should ideally produce different hashValues."
        )
    }
    
    func test_hashable_allowsUniqueInsertionInSet() {
        // GIVEN
        let firstMock = GenreEntity(id: 16, name: "Animation")
        let secondMock = GenreEntity(id: 16, name: "Animation")
        let thirdMock = GenreEntity(id: 35, name: "Comedy")
        
        // WHEN
        var set: Set<GenreEntity> = []
        set.insert(firstMock)
        set.insert(secondMock)
        set.insert(thirdMock)
        
        // THEN
        XCTAssertEqual(
            set.count,
            2,
            "firstMock and secondMock are equal, therefore the Set must contain only 2 elements"
        )
    }
}
