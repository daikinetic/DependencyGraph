
import SwiftUI

#Preview {
  ContentView(root: sampleDependency)
}

struct ContentView: View {

  var root: Dependency

  var body: some View {
    GeometryReader { geometry in
      ScrollView([.horizontal, .vertical]) { // スクロール可能にする
        Group {
          DependencyNodeView(
            node: root,
            depth: 0,
            horizontalSpacing: 150, // 画面幅に基づく間隔調整
            verticalSpacing: 100,
            totalChildren: root.children.count, // ルートノードには 1 つの子ノードがあると仮定
            nodeIndex: 1 // ルートノードのインデックス
          )
          .frame(width: max(geometry.size.width, 2000), height: max(geometry.size.height, 2000)) // 全体サイズの調整
          .background(Color.gray) // 背景色を設定
        }
        .padding()
      }
    }
  }
}

