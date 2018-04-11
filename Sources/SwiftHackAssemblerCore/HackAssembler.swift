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

    // MARK: Lifecycle

    public init() {}

    // MARK: Methods

    public func run() throws {
        guard let filePath = CommandLine.arguments.first, !filePath.isEmpty else {
            print("Please provide a valid path")
            exit(EXIT_FAILURE)
        }

        // 1. Get the file contents
        let rawLines = try fileContentProvider.getFileContents(at: filePath)
        // 2. Strip the lines of whitespace and comments
        let strippedLines = stripper.strip(lines: rawLines)
        // 3. Resolve the symbols
        let symbolsResolvedLines = symbolResolver.resolveSymbols(in: strippedLines)
        // 4. Extract the A and C instructions from the simple assembly file
        let instructions = instructionParser.parseInstructions(from: symbolsResolvedLines)
        // 5. Translate each instruction into a binary string
        // 6. Write the binary string into an output file
    }
}
