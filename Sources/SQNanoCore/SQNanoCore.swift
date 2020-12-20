import Foundation

public final class SQNanoCore {
  private var exitFlag = false
  private let arguments: [String]

  public init(arguments: [String] = CommandLine.arguments) {
    self.arguments = arguments
  }

  public func runInteractive() {
    while !exitFlag {
      print("sqnano> ", terminator: "")
      guard let command = readLine() else {
        return
      }
      guard command.count > 0 else {
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
      case .quit, .quitAlias:
        exitFlag = true
        return
      }
    }

    print("Unknown command \"\(command)\"")
  }
}
