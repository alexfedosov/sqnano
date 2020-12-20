@testable import SQNanoCore
import XCTest

final class DataTypeTests: XCTestCase {
  func testSchemaCreation() throws {
    let schema = Schema(columns: [DataType.integer])
    let expectedMemoryLayout = DataTypeMemoryLayoutDescription(
        size: MemoryLayout<IntegerDataType>.size,
        stride: MemoryLayout<IntegerDataType>.stride
    )
    XCTAssertEqual(schema.memoryLayout(), expectedMemoryLayout)

    let row = Row()
    let incorrectValues: [Any] = ["Incorrect value"]
    XCTAssertThrowsError(try row.set(values: incorrectValues)) { error in
      XCTAssertEqual(error as! SchemaError, SchemaError.schemaIsNotDefinedYet)
    }

    row.schema = schema
    XCTAssertThrowsError(try row.set(values: incorrectValues)) { error in
      let message = "Column 0 has integer type, but \"Incorrect value\" given"
      XCTAssertEqual(error as! SchemaError, SchemaError.schemaDoesNotMatch(message))
    }

    let correctValues: [Any] = [12]
    XCTAssertNoThrow(try row.set(values: correctValues))
  }
}
