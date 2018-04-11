//
//  InstructionTranslator.swift
//  SwiftHackAssemblerCore
//
//  Created by Piotr Gorzelany on 11/04/2018.
//

import Foundation

public class InstructionTranslator {

    // MARK: Properties

    let jumpTranslationTable: [String: String] = [
        "null": "000",
        "JQT": "001",
        "JEQ": "010",
        "JGE": "011",
        "JLT": "100",
        "JNE": "101",
        "JLE": "110",
        "JMP": "111",
        ]

    // MARK: Lifecycle

    public init() {}

    // MARK: Methods

    /// Translate the assembly instructions into their binary representation
    ///
    /// - Parameter instructions: The simplified assembly instructions
    /// - Returns: An array of machine instructions
    public func translateInstructions(_ instructions: [Instruction]) -> [String] {
        return []
    }
}
