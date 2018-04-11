//
//  CInstruction.swift
//  SwiftHackAssemblerCore
//
//  Created by Piotr Gorzelany on 11/04/2018.
//

import Foundation

public enum CInstruction {
    case compute(computation: String, destination: String)
    case jump(computation: String, jumpOption: String)
}
