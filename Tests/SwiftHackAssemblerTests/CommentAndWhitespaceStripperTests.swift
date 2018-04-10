//
//  CommentAndWhitespaceStripperTests.swift
//  SwiftHackAssemblerTests
//
//  Created by Piotr Gorzelany on 10/04/2018.
//

import XCTest
import SwiftHackAssemblerCore

class CommentAndWhitespaceStripperTests: XCTestCase {

    var stripper: CommentAndWhitespaceStripper!
    
    override func setUp() {
        super.setUp()
        stripper = CommentAndWhitespaceStripper()
    }
    
    func testStrippingEmptyLines() {
        let lines = [String]()
        let result = stripper.strip(lines: lines)
        XCTAssert(result.isEmpty, "Results should be empty")
    }

    func testStrippingContentWithWhitespaceOnly() {
        let lines = [
            " ",
            "\n"
        ]

        let results = stripper.strip(lines: lines)
        XCTAssert(results.isEmpty, "Results should be empty - is \(results)")
    }

    func testStrippingComments() {
        let lines = [
            "some code //wow such comment",
            " // only a comment",
            "only code",
            "\n"
        ]

        let results = stripper.strip(lines: lines)
        XCTAssert(results.count == 2, "Only 2 lines are valid")
        XCTAssert(results[0] == "somecode", "Invalid line")
        XCTAssert(results[1] == "onlycode", "Invalid line")
    }
}
