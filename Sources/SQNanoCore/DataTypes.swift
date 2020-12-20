struct DataTypeMemoryLayoutDescription: Equatable {
  let size: Int
  let stride: Int
}

protocol MemoryLayoutDescriptive {
  func memoryLayout() -> DataTypeMemoryLayoutDescription
}

extension DataTypeMemoryLayoutDescription: AdditiveArithmetic {
  static func -(lhs: DataTypeMemoryLayoutDescription, rhs: DataTypeMemoryLayoutDescription) -> DataTypeMemoryLayoutDescription {
    DataTypeMemoryLayoutDescription(size: lhs.size - rhs.size, stride: lhs.stride - rhs.stride)
  }

  static func +(lhs: DataTypeMemoryLayoutDescription, rhs: DataTypeMemoryLayoutDescription) -> DataTypeMemoryLayoutDescription {
    DataTypeMemoryLayoutDescription(size: lhs.size + rhs.size, stride: lhs.stride + rhs.stride)
  }

  static var zero: DataTypeMemoryLayoutDescription {
    DataTypeMemoryLayoutDescription(size: 0, stride: 0)
  }
}

typealias IntegerDataType = Int

enum DataType: String {
  case integer
}

extension DataType: MemoryLayoutDescriptive {
  func memoryLayout() -> DataTypeMemoryLayoutDescription {
    switch self {
    case .integer:
      return DataTypeMemoryLayoutDescription(
          size: MemoryLayout<IntegerDataType>.size,
          stride: MemoryLayout<IntegerDataType>.stride
      )
    }
  }
}

struct Schema {
  let columns: [DataType]
}

extension Schema: MemoryLayoutDescriptive {
  func memoryLayout() -> DataTypeMemoryLayoutDescription {
    columns.map {
      $0.memoryLayout()
    }.reduce(.zero, +)
  }
}

enum SchemaError: Error, Equatable {
  case schemaIsNotDefinedYet
  case schemaDoesNotMatch(_ message: String)
}

class Row {
  var pointer: UnsafeMutableRawPointer?
  var schema: Schema?

  func set(values: [Any]) throws {
    guard let schema = schema else {
      throw SchemaError.schemaIsNotDefinedYet
    }
    guard values.count == schema.columns.count else {
      let message = "Schema has \(schema.columns.count) columns, but \(values.count) values given"
      throw SchemaError.schemaDoesNotMatch(message)
    }

    for (index, value) in values.enumerated() {
      let valueDataType = schema.columns[index]
      switch valueDataType {
      case .integer:
        guard let _ = value as? IntegerDataType else {
          let message = "Column \(index) has \(DataType.integer) type, but \"\(value)\" given"
          throw SchemaError.schemaDoesNotMatch(message)
        }
      }
    }
  }
}


