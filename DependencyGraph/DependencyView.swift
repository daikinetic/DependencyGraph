
import SwiftUI

#Preview {
  DependencyView(dependency: sampleDependency, x: 100, y: 50)
}

public struct DependencyView: View {
  let dependency: Dependency
  let x: CGFloat
  let y: CGFloat

  public var body: some View {
    VStack {
      Text(dependency.name)
        .padding()
        .background(.gray)
        .cornerRadius(8)
        .position(x: x, y: y)

      ForEach(0..<dependency.dependencies.count, id: \.self) { index in
        DependencyView(
          dependency: dependency.dependencies[index],
          x: x + 150,
          y: y + CGFloat(index * 100 + 100)
        )
      }
    }
  }
}

public let sampleDependency = Dependency(
  name: "Sample",
  dependencies: [
    Dependency(name: "Sample A", dependencies: [
      Dependency(name: "Sample C", dependencies: [])
    ]),
    Dependency(name: "Sample B", dependencies: [
      Dependency(name: "Sample D", dependencies: [])
    ])
  ]
)
