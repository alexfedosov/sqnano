import Foundation

enum ControlCommand: String {
  case exit
}

public final class SQNanoCore {
  private let arguments: [String]

  public init(arguments: [String] = CommandLine.arguments) {
    self.arguments = arguments
  }

  public func runInteractive() {
    while true {
      print("sqnano> ", terminator: "")
      guard let command = readLine(), command.count > 0 else {
        print("Press ctrl+c or ctrl+d to exit")
        continue
      }
      execute(command.trimmingCharacters(in: .whitespacesAndNewlines))
    }
  }

  func execute(_ command: String) {
    if let controlCommand = ControlCommand(rawValue: command.lowercased()) {
      switch controlCommand {
      case .exit:
        print("bye!")
        exit(EXIT_SUCCESS)
      }
    }
    print("Unknown command \"\(command)\"")
  }
}
