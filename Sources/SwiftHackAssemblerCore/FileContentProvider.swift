import Foundation

/// Provides the contents of a file as a string
public class FileContentProvider {
    public init() {}

    /// Returns the contents of the file at a given path
    ///
    /// - Parameter path: The full path to the file
    /// - Returns: An array of lines from the file
    public func getFileLines(at path: String) throws -> [String] {
        let data = try getFileContent(at: path)
        return data.components(separatedBy: .newlines)
    }

    public func getFileContent(at path: String) throws -> String {
        return try String.init(contentsOfFile: path)
    }
}
