
import SwiftUI

@main
struct DependencyGraph: App {

  var dependency: Dependency?

  init() {
    print("init")
    let args = CommandLine.arguments
    print("args: \(args)")

    let filePath = args[1]
    dependency = parseJSON()
  }

  var body: some Scene {

    WindowGroup {
      let contentView = ContentView(dependency: dependency ?? sampleDependency)
      contentView
        .onAppear {
          let tmpImagePath = FileManager.default.temporaryDirectory.appendingPathComponent("dependencies.png").path
          print("tmpImagePath: \(tmpImagePath)")

          let image = contentView.snapshot()
          saveImage(image: image, to: tmpImagePath)

        }
    }
  }

  private func moveImageToCurrentDirectory(from tmpImagePath: String, to destinationDirectoryPath: String) {
    let fileManager = FileManager.default
    do {
      if fileManager.fileExists(atPath: destinationDirectoryPath) {
        try fileManager.removeItem(atPath: destinationDirectoryPath)
      }
      try fileManager.moveItem(atPath: tmpImagePath, toPath: destinationDirectoryPath)
      print("Image moved to \(destinationDirectoryPath)")
    } catch {
      print("Failed to move image: \(error)")
    }
  }
}
