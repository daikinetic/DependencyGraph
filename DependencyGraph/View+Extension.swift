
import SwiftUI

extension View {
  public func snapshot() -> NSImage {
    let controller = NSHostingController(rootView: self)
    let view = controller.view

    let targetSize = CGSize(width: 1200, height: 800)
    view.setFrameSize(targetSize)
    view.layoutSubtreeIfNeeded()

    let bitmapRep = view.bitmapImageRepForCachingDisplay(in: view.bounds)!
    view.cacheDisplay(in: view.bounds, to: bitmapRep)

    let image = NSImage(size: targetSize)
    image.addRepresentation(bitmapRep)
    return image
  }
}

public func saveImage(image: NSImage, to filePath: String) {
  let data = image.tiffRepresentation
  let bitmapRep = NSBitmapImageRep(data: data!)
  let pngData = bitmapRep?.representation(using: .png, properties: [:])
  let url = URL(fileURLWithPath: filePath)
  try? pngData?.write(to: url)
  print("Image saved to \(url)")
}
