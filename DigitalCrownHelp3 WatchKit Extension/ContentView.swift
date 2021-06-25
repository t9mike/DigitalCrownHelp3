//
//  ContentView.swift
//  DigitalCrownHelp3 WatchKit Extension
//
//  Created by Michael S. Muegel on 6/24/21.
//

import SwiftUI

class GlobalState : ObservableObject {
    @Published var enableCrown = false
}

struct ChildView: View {
    @State var crownValue = 0.0
    @ObservedObject var globalState = ContentView.globalState
    @Environment(\.resetFocus) var resetFocus

    let label: String
    let namespace: Namespace.ID
    
    init(_ label: String, ns: Namespace.ID) {
        self.label = label
        self.namespace = ns
    }
    
    var body: some View {
        ScrollView {
            Text(label)
            Button("\(globalState.enableCrown ? "Disable" : "Enable") Crown") {
                globalState.enableCrown = !globalState.enableCrown
            }
            .focusable()
            .prefersDefaultFocus(true, in: namespace)
//            .prefersDefaultFocus(globalState.enableCrown, in: namespace)
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
    @State private var tabSelection = 1
    @Namespace private var namespace
    @Environment(\.resetFocus) var resetFocus

    var body: some View {
        TabView(selection: $tabSelection) {
            ChildView("Tab #1", ns: namespace)
                .tag(1)
            ChildView("Tab #2", ns: namespace)
                .tag(2)
            ChildView("Tab #3", ns: namespace)
                .tag(3)
        }
        .onChange(of: tabSelection, perform: { value in
            print("tab is now \(tabSelection)")
            resetFocus(in: namespace)
//            if ContentView.globalState.enableCrown {
//                resetFocus(in: namespace)
//            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
