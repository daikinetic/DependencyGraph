
import Foundation

public struct DependencyNode: Decodable {
//  let id = UUID()
  let name: String
  let dependencies: [DependencyNode]
}

func parseJSON() -> DependencyNode? {
  if let url = Bundle.main.url(forResource: "dependencies", withExtension: "json") {
    print("url: \(url) \n")
    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      return try decoder.decode(DependencyNode.self, from: data)
    } catch {
      print("Error reading file at \(url): \(error)")
      return nil
    }
  }
  print("File not found")
  return nil
}

func logMessage(_ message: String, to logFilePath: URL) {
    do {
        let timestamp = Date().description(with: .current)
        let fullMessage = "[\(timestamp)] \(message)"

        if FileManager.default.fileExists(atPath: logFilePath.path) {
            let fileHandle = try FileHandle(forWritingTo: logFilePath)
            fileHandle.seekToEndOfFile()
            fileHandle.write((fullMessage + "\n").data(using: .utf8)!)
            fileHandle.closeFile()
        } else {
          print(fullMessage)
            try (fullMessage + "\n").write(to: logFilePath, atomically: true, encoding: .utf8)
        }
    } catch {
        print("Failed to log message: \(error)")
    }
}
