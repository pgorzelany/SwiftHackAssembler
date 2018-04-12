//
//  SymbolResolverTests.swift
//  SwiftHackAssemblerTests
//
//  Created by Piotr Gorzelany on 11/04/2018.
//

import XCTest
import SwiftHackAssemblerCore

class SymbolResolverTests: XCTestCase {

    var resolver: SymbolResolver!
    
    override func setUp() {
        super.setUp()

        resolver = SymbolResolver()
    }

    func testResolvingEmptyLines() {
        let lines: [String] = []

        let results = resolver.resolveSymbols(in: lines)
        XCTAssert(results.isEmpty, "Results should be empty")
    }

    func testResolvingBuiltInSymbols() {
        let lines = [
            "@SP",
            "D;JMP",
            "@SCREEN",
            "0;JMP",
            "@123"
        ]

        let results = resolver.resolveSymbols(in: lines)
        XCTAssert(results[0] == "@0", "SP should be resolved, is \(results[0])")
        XCTAssert(results[1] == "D;JMP", "C instructions should remain intact")
        XCTAssert(results[2] == "@16384", "SCREEN should be resolved")
        XCTAssert(results[4] == "@123", "This line should stay the same")
    }

    func testResolvingLabels() {
        let lines = [
            "(LOOP)",
            "D;JMP",
            "@LOOP",
            "(END)",
            "@END",
            "0;JMP"
        ]

        let results = resolver.resolveSymbols(in: lines)
        XCTAssert(results.count == 4, "Label declarations should be removed")
        XCTAssert(results[0] == "D;JMP", "This line should be changed")
        XCTAssert(results[1] == "@0", "Label pointed to instruction 0")
        XCTAssert(results[2] == "@2", "Label pointed to instruction 2")
        XCTAssert(results[3] == "0;JMP", "This line should be changed")
    }

    func testResolvingVariables() {
        let lines = [
            "@x",
            "0;JMP",
            "@y",
            "@x"
        ]

        let results = resolver.resolveSymbols(in: lines)
        XCTAssert(results[0] == "@16", "First variable should have address 16")
        XCTAssert(results[2] == "@17", "Second variable should have address 17")
        XCTAssert(results[3] == "@16", "First variable should have address 16")
    }
}
