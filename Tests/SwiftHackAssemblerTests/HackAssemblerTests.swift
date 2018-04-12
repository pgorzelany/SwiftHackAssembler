//
//  HackAssemblerTests.swift
//  SwiftHackAssemblerTests
//
//  Created by Piotr Gorzelany on 12/04/2018.
//

import XCTest
import SwiftHackAssemblerCore

class HackAssemblerTests: XCTestCase {

    var assembler: HackAssembler!
    var fileContentProvider: FileContentProvider!
    var fillFilePath: String!
    var fillExpectedResultsFilePath: String!
    var multFilePath: String!
    var multExpectedResultsFilePath: String!
    
    override func setUp() {
        super.setUp()

        assembler = HackAssembler()
        fileContentProvider = FileContentProvider()
        let currentDir = FileManager.default.currentDirectoryPath
        let stubsDir = "\(currentDir)/Tests/SwiftHackAssemblerTests/Stubs/"
        fillFilePath = "\(stubsDir)Fill.asm"
        fillExpectedResultsFilePath = "\(stubsDir)Fill.hack"
        multFilePath = "\(stubsDir)Mult.asm"
        multExpectedResultsFilePath = "\(stubsDir)Mult.hack"
    }

    func testAssemblingFillProgram() {
        do {
            let fillProgramLines = fillInput.components(separatedBy: .newlines)
            let results = try assembler.assembleProgram(lines: fillProgramLines)
            let resultLines = results.components(separatedBy: .newlines)
            let expectedResults = fillOutput
            let expectedResultsLines = expectedResults.components(separatedBy: .newlines)
            XCTAssert(resultLines.count == expectedResultsLines.count, "The results and expected results should have the same number of lines")
            for index in 0..<resultLines.count {
                if resultLines[index] != expectedResultsLines[index] {
                    XCTAssert(false, "Machine instruction different at line \(index).\n\(resultLines[index])\n\(expectedResultsLines[index])")
                }
            }
        } catch {
            XCTAssert(false, error.localizedDescription)
        }
    }

    func testAssemblingMultProgram() {
        do {
            let fillProgramLines = multInput.components(separatedBy: .newlines)
            let results = try assembler.assembleProgram(lines: fillProgramLines)
            let resultLines = results.components(separatedBy: .newlines)
            let expectedResults = multOutput
            let expectedResultsLines = expectedResults.components(separatedBy: .newlines)
            XCTAssert(resultLines.count == expectedResultsLines.count, "The results and expected results should have the same number of lines")
            for index in 0..<resultLines.count {
                if resultLines[index] != expectedResultsLines[index] {
                    XCTAssert(false, "Machine instruction different at line \(index).\n\(resultLines[index])\n\(expectedResultsLines[index])")
                }
            }
        } catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
}
