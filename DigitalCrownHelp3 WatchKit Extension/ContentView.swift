//
//  ContentView.swift
//  DigitalCrownHelp3 WatchKit Extension
//
//  Created by Michael S. Muegel on 6/24/21.
//

import SwiftUI

struct ChildView: View {
    @State var crownValue = 0.0
    let label: String

    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        ScrollView {
            Text(label)
            Button("Enable Crown") {
            }
            .focusable()
            .digitalCrownRotation($crownValue)
            .onChange(of: crownValue, perform: { value in
                print("crownValue is \(crownValue)")
            })
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            ChildView("hello")
            ChildView("world")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
