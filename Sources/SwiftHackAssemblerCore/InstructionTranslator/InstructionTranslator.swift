//
//  InstructionTranslator.swift
//  SwiftHackAssemblerCore
//
//  Created by Piotr Gorzelany on 11/04/2018.
//

import Foundation

public class InstructionTranslator {

    // MARK: Properties


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
