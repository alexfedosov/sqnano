import Foundation

func quit() {
  print("")
  print("Bye!")
  exit(EXIT_SUCCESS)
}

public final class SQNanoCore {
  private let arguments: [String]

  public init(arguments: [String] = CommandLine.arguments) {
    self.arguments = arguments
  }

  func trapSignals() {
    signal(SIGINT, { _ in quit() })
  }

  public func runInteractive() {
    trapSignals()
    while true {
      print("sqnano> ", terminator: "")
      guard let command = readLine() else {
        return quit()
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
      case .quit, .quitAlias: quit()
      }
    }

    print("Unknown command \"\(command)\"")
  }
}
