@testable import SQNanoCore
import XCTest

final class MetaCommandTests: XCTestCase {
  func testValidCommands() throws {
    let validCommands = [
      "quit",
      "q"
    ]
    for command in validCommands {
      let metaCommand = MetaCommand(rawValue: command)
      let raw = try XCTUnwrap(metaCommand)
      XCTAssertEqual(raw.rawValue, command)
    }
  }
}
