import SwiftUI

class GlobalState : ObservableObject {
    @Published var enableCrown = false
}

struct ChildView: View {
    @State var crownValue = 0.0
    @ObservedObject var globalState = ContentView.globalState
    @Namespace private var namespace
    @Environment(\.resetFocus) var resetFocus
    
    let label: String

    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        ScrollView {
            Text(label)
            Button("\(globalState.enableCrown ? "Disable" : "Enable") Crown") {
                globalState.enableCrown = !globalState.enableCrown
            }
            .focusable()
            .prefersDefaultFocus(globalState.enableCrown, in: namespace)
            .digitalCrownRotation($crownValue)
            .onChange(of: crownValue, perform: { value in
                print("crownValue is \(crownValue)")
            })
        }
        .focusScope(namespace)
        .onAppear {
            print("\(label), enableCrown=\(globalState.enableCrown)")
            resetFocus(in: namespace)
        }
    }
}

struct ContentView: View {
    static let globalState = GlobalState()
    
    var body: some View {
        TabView {
            ChildView("Tab #1")
            ChildView("Tab #2")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
