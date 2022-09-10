//
//  ContentView.swift
//  Shared
//
//  Created by Kaori Persson on 2022-09-10.
//

import SwiftUI
import SwiftUIBamMiniPlayerLibrary

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        
        PlayerView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
