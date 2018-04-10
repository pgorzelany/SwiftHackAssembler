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
        guard let filePath = CommandLine.arguments.first else {
            fatalError("Please provide a filepath")
        }

        let rawLines = try fileContentProvider.getFileContents(at: filePath)
        let strippedLines = stripper.strip(lines: rawLines)
    }
}
