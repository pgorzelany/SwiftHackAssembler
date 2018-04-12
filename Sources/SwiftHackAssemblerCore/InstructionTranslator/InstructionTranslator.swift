//
//  InstructionTranslator.swift
//  SwiftHackAssemblerCore
//
//  Created by Piotr Gorzelany on 11/04/2018.
//

import Foundation

public class InstructionTranslator {

    // MARK: Properties

    private let jumpTranslationTable: [String: String] = [
        "null": "000",
        "JQT": "001",
        "JEQ": "010",
        "JGE": "011",
        "JLT": "100",
        "JNE": "101",
        "JLE": "110",
        "JMP": "111",
        ]

    private let destinationTranslationTable: [String: String] = [
        "null": "000",
        "M": "001",
        "D": "010",
        "MD": "011",
        "A": "100",
        "AM": "101",
        "AD": "110",
        "AMD": "111",
    ]

    private let computationTranslationTable: [String: String] = [
        "0": "0101010",
        "1": "0111111",
        "-1": "0111010",
        "D": "0001100",
        "A": "0110000",
        "M": "1110000",
        "!D": "0001101",
        "!A": "0110001",
        "!M": "1110001",
        "-D": "0001111",
        "-A": "0110011",
        "-M": "1110011",
        "D+1": "0011111",
        "A+1": "0110111",
        "M+1": "1110111",
        "D-1": "0001110",
        "A-1": "0110010",
        "M-1": "1110010",
        "D+A": "0000010",
        "D+M": "1000010",
        "D-A": "0010011",
        "D-M": "1010011",
        "A-D": "0000111",
        "M-D": "1000111",
        "D&A": "0000000",
        "D&M": "1000000",
        "D|A": "0010101",
        "D|M": "1010101"
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

    private func translateInstruction(_ instruction: Instruction) -> String {
        switch instruction {
        case .AInstruction(let aInstruction):
            return translateAInstruction(aInstruction)
        case .CInstruction(let cInstruction):
            return translateCInstruction(cInstruction)
        }
    }

    private func translateAInstruction(_ instruction: AInstruction) -> String {
        return getBinaryRepresentation(of: instruction.address, length: 15)
    }

    private func translateCInstruction(_ instruction: CInstruction) -> String {
        fatalError("Not implemented")
    }

    private func getBinaryRepresentation(of address: MemoryAddress, length: UInt) -> String {
        let binaryAddressString = String(address, radix: 2)
        let padding = Int(length) - binaryAddressString.count
        guard padding > 0 else {
            return binaryAddressString
        }

        return String(repeating: "0", count: padding) + binaryAddressString
    }
}
