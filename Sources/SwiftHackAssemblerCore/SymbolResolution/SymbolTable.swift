//
//  SymbolTable.swift
//  SwiftHackAssemblerCore
//
//  Created by Piotr Gorzelany on 11/04/2018.
//

import Foundation

/// Stores the symbols and their respective memory addresses
class SymbolTable {
    typealias SymbolName = String

    // MARK: Properties

    private var symbolDictionary: [SymbolName: MemoryAddress] = [
        "SP": 0,
        "LCL": 1,
        "ARG": 2,
        "THIS": 3,
        "THAT": 4,
        "R0": 0,
        "R1": 1,
        "R2": 2,
        "R3": 3,
        "R4": 4,
        "R5": 5,
        "R6": 6,
        "R7": 7,
        "R8": 8,
        "R9": 9,
        "R10": 10,
        "R11": 11,
        "R12": 12,
        "R13": 13,
        "R14": 14,
        "R15": 15,
        "R16": 16,
        "SCREEN": 16384,
        "KBD": 24576
    ]
    private var nextVariableMemoryAddress = 16

    // MARK: Methods

    func addLabelSymbol(name: SymbolName, address: MemoryAddress) {
        symbolDictionary[name] = address
    }

    func getAddress(for symbol: SymbolName) -> MemoryAddress {
        let address = symbolDictionary[symbol, default: nextVariableMemoryAddress]
        nextVariableMemoryAddress += 1
        return address
    }
}
