import Foundation

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
    if command.starts(with: "\\") {
      guard command.count > 0,
            let metaCommand = MetaCommand(rawValue: String(command.dropFirst())) else {
        print("Unrecognized meta-command: \"\(command)\"")
        return
      }
      switch metaCommand {
      case .quit, .quitAlias: exit(EXIT_SUCCESS)
      }
    }

    print("Unknown command \"\(command)\"")
  }
}
