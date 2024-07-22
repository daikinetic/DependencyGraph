
import SwiftUI

#Preview {
  ContentView(dependency: sampleDependency)
}

struct ContentView: View {

  var dependency: Dependency

  var body: some View {
    ScrollView {
      DependencyView(
        dependency: dependency,
        x: 100,
        y: 50
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

