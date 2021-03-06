//
//  SymbolResolver.swift
//  SwiftHackAssemblerCore
//
//  Created by Piotr Gorzelany on 10/04/2018.
//

import Foundation

/// Resolves and strippes the symbols from the assembly
public class SymbolResolver {

    // MARK: Properties

    private let symbolTable = SymbolTable()

    // MARK: Lifecycle

    public init() {}

    // MARK: Methods

    /// Resolves and translates the symbols into memory addresses
    ///
    /// - Parameter lines: The assembly program lines, stripped of whitespace and comments
    /// - Returns: Returnes a simplified assembly program with no symbols
    public func resolveSymbols(in lines: [String]) -> [String] {
        var result = lines
        resolveLabelDeclarations(in: result)
        result = removeLabelDeclarations(in: result)
        return translateSymbols(in: result)
    }

    private func resolveLabelDeclarations(in lines: [String]) {
        var labelCount: UInt = 0
        for (index, line) in lines.enumerated() {
            if let labelName = extractLabelDeclaration(from: line) {
                symbolTable.addLabelSymbol(name: labelName, address: UInt(index) - labelCount)
                labelCount += 1
            }
        }
    }

    private func removeLabelDeclarations(in lines: [String]) -> [String] {
        return lines.filter({ (line) -> Bool in
            return extractLabelDeclaration(from: line) == nil
        })
    }

    private func translateSymbols(in lines: [String]) -> [String] {
        return lines.map({ (line) -> String in
            guard let symbolName = extractSymbol(from: line) else {
                // There is no symbol in this line so just return it as is
                return line
            }

            let symbolAddress = symbolTable.getAddress(for: symbolName)
            return "@\(symbolAddress)"
        })
    }

    /// Returns a label name if its in the line
    private func extractLabelDeclaration(from line: String) -> String? {
        guard line.first == "(", line.last == ")", line.count > 3 else {
            return nil
        }

        var result = line
        result.removeFirst()
        result.removeLast()
        return result
    }

    private func extractSymbol(from line: String) -> String? {
        guard line.first == "@", line.count > 1 else {
            return nil
        }

        var symbol = line
        symbol.removeFirst()
        guard Int(symbol) == nil else {
            // If the symbol is a number like @17 then its a raw address and we should leave it alone
            return nil
        }

        return symbol
    }
}
