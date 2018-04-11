//
//  InstructionParser.swift
//  SwiftHackAssemblerCore
//
//  Created by Piotr Gorzelany on 11/04/2018.
//

import Foundation

public class InstructionParser {

    // MARK: Properties


    // MARK: Lifecycle

    public init() {}

    // MARK: Methods

    public func parseInstructions(from lines: [String]) -> [Instruction] {
        var instructions = [Instruction]()
        for line in lines {
            if let aInstruction = extractAInstruction(from: line) {
                instructions.append(Instruction.AInstruction(aInstruction))
            } else if let cInstruction = extractCInstruction(from: line) {
                instructions.append(Instruction.CInstruction(cInstruction))
            }
        }
        return instructions
    }

    private func extractAInstruction(from line: String) -> AInstruction? {
        guard line.first == "@" else {
            return nil
        }

        var instruction = line
        instruction.removeFirst()
        guard let address = UInt(instruction) else {
            return nil
        }

        return AInstruction(address: address)
    }

    private func extractCInstruction(from line: String) -> CInstruction? {
        let computationCandidate = line.split(separator: "=")
        if computationCandidate.count == 2 {
            let destination = computationCandidate[0]
            let computation = computationCandidate[1]
            return CInstruction.compute(computation: String(computation), destination: String(destination))
        }

        let jumpCandidate = line.split(separator: ";")
        if jumpCandidate.count == 2 {
            let computation = jumpCandidate[0]
            let jumpOption = jumpCandidate[1]
            return CInstruction.jump(computation: String(computation), jumpOption: String(jumpOption))
        }

        return nil
    }
}
