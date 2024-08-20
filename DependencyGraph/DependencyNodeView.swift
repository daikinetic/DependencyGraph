
import SwiftUI

#Preview {
  DependencyNodeView(dependency: sampleDependency, x: 100, y: 50)
}

public struct DependencyNodeView: View {
  let dependency: DependencyNode
  let x: CGFloat
  let y: CGFloat

  public var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(dependency.name)
        .padding()
        .background(.blue.opacity(0.9))
        .cornerRadius(8)
        .foregroundColor(.white)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(.white, lineWidth: 2)
        )
        .shadow(radius: 3)
        .position(x: x, y: y)

      ForEach(0..<dependency.dependencies.count, id: \.self) { index in
        DependencyNodeView(
          dependency: dependency.dependencies[index],
          x: x + 100,
          y: y + CGFloat(index * 50 + 50)
        )
      }
    }
  }
}

public let sampleDependency = DependencyNode(
  name: "Sample",
  dependencies: [
    DependencyNode(name: "Sample A", dependencies: [
      DependencyNode(name: "Sample C", dependencies: [])
    ]),
    DependencyNode(name: "Sample B", dependencies: [
      DependencyNode(name: "Sample D", dependencies: [])
    ])
  ]
)
