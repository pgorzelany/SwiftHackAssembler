import Foundation
import SwiftHackAssemblerCore

guard let filePath = CommandLine.arguments.first else {
    fatalError("Please provide a filepath")
}

do {
    let assembler = HackAssembler()
    try assembler.run()
} catch {
    print("An error occured")
}
