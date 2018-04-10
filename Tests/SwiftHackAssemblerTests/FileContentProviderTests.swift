import XCTest
import SwiftHackAssemblerCore

class FileContentProviderTests: XCTestCase {

    var fileContentProvider: FileContentProvider!
    var stubFilePath: String!

    override func setUp() {
        super.setUp()

        fileContentProvider = FileContentProvider()
        let currentDir = FileManager.default.currentDirectoryPath
        let relativeFilePath = "Tests/SwiftHackAssemblerTests/Stubs/FileContentStub"
        stubFilePath = "\(currentDir)/\(relativeFilePath)"
    }

    func testReadingContentsOfFile() {
        do {
            _ = try fileContentProvider.getFileContents(at: stubFilePath)
        } catch {
            XCTAssert(false, "Could not get contents of file")
        }
    }

    func testReadingAllLinesOfFile() {
        do {
            let contents = try fileContentProvider.getFileContents(at: stubFilePath)
            XCTAssert(contents.count == 6, "The content should have 6 lines. It has \(contents.count)")
        } catch {
            XCTAssert(false, "Could not get contents of file")
        }
    }

    func testReadingSpecificLines() {
        do {
            let contents = try fileContentProvider.getFileContents(at: stubFilePath)
            XCTAssert(contents[0] == "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "Line was not read correctly")
            XCTAssert(contents[4] == "sunt in culpa qui officia deserunt mollit anim id est laborum.", "Contents no read correctly")
            XCTAssert(contents[5].isEmpty, "Last line should be empty")
        } catch {
            XCTAssert(false, "Could not get contents of file")
        }
    }
}
