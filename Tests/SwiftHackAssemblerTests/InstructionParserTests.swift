//
//  InstructionParserTests.swift
//  SwiftHackAssemblerTests
//
//  Created by Piotr Gorzelany on 11/04/2018.
//

import XCTest
import SwiftHackAssemblerCore

class InstructionParserTests: XCTestCase {

    var parser: InstructionParser!
    
    override func setUp() {
        super.setUp()

        parser = InstructionParser()
    }

    func testParsingAInstructions() {
        let lines = [
            "@24",
            "// comment",
            "@loop",
            "@1002"
        ]

        let instructions = parser.parseInstructions(from: lines)
        XCTAssert(instructions.count == 2, "There are only 2 valid instructions")
        switch instructions[0] {
        case .AInstruction(let instruction):
            XCTAssert(instruction.address == 24, "The instruction address is wrong")
        case .CInstruction:
            XCTAssert(false, "Lines contain only A instructions")
        }
    }

    func testParsingCInstructions() {
        let lines = [
            "D;JMP",
            "D=A-1"
        ]

        let instructions = parser.parseInstructions(from: lines)
        XCTAssert(instructions.count == 2, "Both instructions are valid")

        switch instructions[0] {
        case .CInstruction(let instruction):
            switch instruction {
            case .compute:
                XCTAssert(false, "This is not a compute instruction")
            case .jump(let computation, let jumpOption):
                XCTAssert(computation=="D", "Wrong computation swtring")
                XCTAssert(jumpOption == "JMP", "Wrong jump option")
            }
        case .AInstruction:
            XCTAssert(false, "This is not an A instruction")
        }

        switch instructions[1] {
        case .CInstruction(let instruction):
            switch instruction {
            case .compute(let computation, let destination):
                XCTAssert(computation == "A-1", "Wrong computation string")
                XCTAssert(destination == "D", "Wrong destination string")
            case .jump:
                XCTAssert(false, "This is not a compute instruction")
            }
        case .AInstruction:
            XCTAssert(false, "This is not an A instruction")
        }
    }
}
