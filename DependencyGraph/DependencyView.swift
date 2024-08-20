
import SwiftUI

//#Preview {
//  DependencyView(dependency: sampleDependency, x: 100, y: 50)
//}

struct DependencyNodeView: View {
  let node: Dependency
  let depth: Int
  let horizontalSpacing: CGFloat
  let verticalSpacing: CGFloat
  let totalChildren: Int
  let nodeIndex: Int

  let nodeWidth: CGFloat = 100
  let nodeHeight: CGFloat = 50

  // ノードの位置を計算
  func calculatePosition(depth: Int, nodeIndex: Int, totalChildren: Int) -> CGPoint {
    let xPosition = CGFloat(depth) * horizontalSpacing
    let yOffset = CGFloat(nodeIndex - totalChildren / 2) * verticalSpacing
    return CGPoint(x: xPosition, y: yOffset)
  }

  var body: some View {
    ZStack(alignment: .topLeading) {
      // ノードの表示
      VStack {
        Text(node.name)
          .padding()
          .background(Color.blue)
          .cornerRadius(8)
          .border(Color.purple, width: 2)
          .frame(width: nodeWidth, height: nodeHeight)
      }
      .offset(x: calculatePosition(depth: depth, nodeIndex: nodeIndex, totalChildren: totalChildren).x,
              y: calculatePosition(depth: depth, nodeIndex: nodeIndex, totalChildren: totalChildren).y)

      // 再帰的に子ノードを描画
      ForEach(node.children.indices, id: \.self) { childIndex in

        DependencyNodeView(
          node: node.children[childIndex],
          depth: depth + 1,
          horizontalSpacing: horizontalSpacing,
          verticalSpacing: verticalSpacing,
          totalChildren: node.children.count,
          nodeIndex: childIndex
        )
        .offset(x: calculatePosition(depth: depth + 1, nodeIndex: childIndex, totalChildren: node.children.count).x,
                y: calculatePosition(depth: depth + 1, nodeIndex: childIndex, totalChildren: node.children.count).y)
      }
    }
    .overlay(
      ForEach(node.children.indices, id: \.self) { childIndex in
        Path { path in
          let childPosition = calculatePosition(depth: depth + 1, nodeIndex: childIndex, totalChildren: node.children.count)
          let parentPosition = calculatePosition(depth: depth, nodeIndex: nodeIndex, totalChildren: totalChildren)

          // 矢印の開始点と終了点
          path.move(to: CGPoint(x: parentPosition.x + nodeWidth, y: parentPosition.y + nodeHeight / 2))
          path.addLine(to: CGPoint(x: childPosition.x + nodeWidth, y: childPosition.y - nodeHeight / 2))
        }
        .stroke(.blue, lineWidth: 2) // 矢印の色を設定
      }

    )
  }
}

public let sampleDependency = Dependency(
  name: "Root",
  children: [
    Dependency(name: "Child A", children: [
      Dependency(name: "Grandchild A1", children: []),
      Dependency(name: "Grandchild A2", children: [])
    ]),
    Dependency(name: "Child B", children: [
      Dependency(name: "Grandchild B1", children: []),
      Dependency(name: "Grandchild B2", children: [])
    ]),
    Dependency(name: "Child C", children: [
      Dependency(name: "Grandchild C1", children: []),
      Dependency(name: "Grandchild C2", children: [])
    ]),
    Dependency(name: "Child D", children: [
      Dependency(name: "Grandchild D1", children: []),
      Dependency(name: "Grandchild D2", children: [])
    ])
  ]
)
