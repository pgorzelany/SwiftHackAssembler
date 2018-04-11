import Foundation
import SwiftHackAssemblerCore

do {
    let assembler = HackAssembler()
    try assembler.run()
} catch {
    print(error)
}
