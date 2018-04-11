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

    // MARK: Lifecycle

    public init() {}

    // MARK: Methods

    public func run() throws {
        guard let filePath = CommandLine.arguments.first, !filePath.isEmpty else {
            print("Please provide a valid path")
            exit(EXIT_FAILURE)
        }

        let rawLines = try fileContentProvider.getFileContents(at: filePath)
        let strippedLines = stripper.strip(lines: rawLines)
        // 1. Get the file contents
        // 2. Strip the lines of whitespace and comments
        // 3. Get label symbols and their addresses
        // 4. Get the variable symbols and their addresses
        // 5. Replace all symbols with their raw addresses @address
        // 6. Extract the A and C instructions from the simple assembly file
        // 7. Transalte each instruction into a binary string
        // 8. Write the binary string into an output file
    }
}
