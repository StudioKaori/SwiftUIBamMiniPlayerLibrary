//
//  ContentView.swift
//  Shared
//
//  Created by Kaori Persson on 2022-09-10.
//

import SwiftUI
import SwiftUIBamMiniPlayerLibrary

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var playerStatus = PlayerStatus.shared
    @StateObject private var playerMessageHandler = PlayerMessageHandler.shared
    
    // MARK: - Body
    var body: some View {
        ZStack {
            NavigationView {
                VStack{
                    NavigationLink(destination: {
                        ProductPageView()
                    }, label: {
                        Text("Product page")
                    })
                    .padding()
                    
                    Button(action: {
                        PlayerWebView.shared.playerOpen(showID: "sXzOW4o0zpDXFIu7zg9S")
                    }, label: {
                        Text(playerStatus.isPlayerViewVisible ? "Close the player" : "Open the player")
                        
                    })
                    
                    NavigationLink(destination: ProductPageView(), isActive: $playerMessageHandler.isChildViewVisible, label: {
                        EmptyView()
                    })
                } //: VStack
            } //: Navigation View
            
            // Player
            PlayerView()

            
        } //: Zstack
        .onAppear(perform: {
            playerStatus.showID = "sXzOW4o0zpDXFIu7zg9S"
            playerStatus.isPlayerViewVisible = true
        })

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
