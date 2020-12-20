import Foundation
import SQNanoCore

func quit() {
  print("")
  print("Bye!")
  exit(EXIT_SUCCESS)
}

signal(SIGINT, { _ in quit() })

let app = SQNanoCore()
app.runInteractive()
quit()
