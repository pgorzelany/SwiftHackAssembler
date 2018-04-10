import Foundation
import SwiftHackAssemblerCore

guard let filePath = CommandLine.arguments.first else {
    fatalError("Please provide a filepath")
}

let fileContentProvider = FileContentProvider()
do {
    let fileContent = try fileContentProvider.getFileContents(at: filePath)
    print(fileContent)
} catch {
    print("An error occured")
}
