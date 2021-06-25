//
//  ContentView.swift
//  DigitalCrownHelp3 WatchKit Extension
//
//  Created by Michael S. Muegel on 6/24/21.
//

import SwiftUI

class GlobalState : ObservableObject {
    @Published var forceFocus = false
}

struct ChildView: View {
    @State var crownValue = 0.0
    @ObservedObject var globalState = ContentView.globalState
    @Namespace private var namespace
    
    let label: String

    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        ScrollView {
            Text(label)
            Button("\(globalState.forceFocus ? "Disable" : "Enable") Crown") {
                globalState.forceFocus = !globalState.forceFocus
            }
            .focusable()
            .prefersDefaultFocus(globalState.forceFocus, in: namespace)
            .digitalCrownRotation($crownValue)
            .onChange(of: crownValue, perform: { value in
                print("crownValue is \(crownValue)")
            })
        }
        .focusScope(namespace)
        .onAppear {
            print("\(label), forceFocus=\(globalState.forceFocus)")
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
