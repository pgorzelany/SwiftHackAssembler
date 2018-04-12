//
//  HackAssembler.swift
//  SwiftHackAssemblerCore
//
//  Created by Piotr Gorzelany on 10/04/2018.
//

import Foundation

public class HackAssembler {

    // MARK: Propertie

    let fileContentProvider = FileContentProvider()
    let stripper = CommentAndWhitespaceStripper()
    let symbolResolver = SymbolResolver()
    let instructionParser = InstructionParser()
    let instructionTranslator = InstructionTranslator()

    // MARK: Lifecycle

    public init() {}

    // MARK: Methods

    public func run() throws {
        guard CommandLine.arguments.count == 2 else {
            print("Please provide a valid path")
            exit(EXIT_FAILURE)
        }

        let filePath = CommandLine.arguments[1]
        guard !filePath.isEmpty else {
            print("Please provide a valid path")
            exit(EXIT_FAILURE)
        }

        print(try assembleFile(at: filePath))
    }

    public func assembleFile(at filePath: String) throws -> String {
        // 1. Get the file contents
        let rawLines = try fileContentProvider.getFileLines(at: filePath)
        return try assembleProgram(lines: rawLines)
    }

    public func assembleProgram(lines rawLines: [String]) throws -> String {
        // 2. Strip the lines of whitespace and comments
        let strippedLines = stripper.strip(lines: rawLines)
        // 3. Resolve the symbols
        let symbolsResolvedLines = symbolResolver.resolveSymbols(in: strippedLines)
        // 4. Extract the A and C instructions from the simple assembly file
        let instructions = instructionParser.parseInstructions(from: symbolsResolvedLines)
        // 5. Translate each instruction into a binary string
        let machineInstructions = try instructionTranslator.translateInstructions(instructions)
        // 6. Return the complete program translated to machine instructions
        return machineInstructions.joined(separator: "\n")
    }
}
