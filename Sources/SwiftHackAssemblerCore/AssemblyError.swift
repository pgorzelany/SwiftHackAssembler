//
//  File.swift
//  SwiftHackAssemblerCore
//
//  Created by Piotr Gorzelany on 12.04.2018.
//

import Foundation

class AssemblyError: NSError {
    convenience init(message: String) {
        self.init(domain: "HackAssembler", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
