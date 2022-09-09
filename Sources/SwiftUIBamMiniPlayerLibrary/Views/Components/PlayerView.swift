//
//  PlayerView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-01.
//

import SwiftUI

@available(iOS 13.0, *)
struct PlayerView: View {
    // MARK: - Properties
    @StateObject private var playerStatus = PlayerStatus.shared
    
    @State private var location: CGPoint = CGPoint(
        x: UIScreen.main.bounds.width - miniPlayerWidth/2 - miniPlayerMarginFromEdge,
        y: UIScreen.main.bounds.height - miniPlayerHeight/2 - miniPlayerMarginFromEdge
    )
    
    private let playerUrl: String = "https://demo.bambuser.shop/content/webview-landing-v2.html?mockLiveBambuser=true"
    
    private let miniPlayerPositionLeadingX: CGFloat = miniPlayerMarginFromEdge + miniPlayerWidth/2
    private let miniPlayerPositionLeadingY: CGFloat = miniPlayerMarginFromEdge + miniPlayerHeight/2
    private let miniPlayerPositionTrailingX: CGFloat = UIScreen.main.bounds.width - miniPlayerWidth/2 - miniPlayerMarginFromEdge
    private let miniPlayerPositionTrailingY: CGFloat = UIScreen.main.bounds.height - miniPlayerHeight/2 - miniPlayerMarginFromEdge
    
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if (PlayerStatus.shared.isPlayerViewVisible) {
                //PlayerViewWrapper()
                
                ZStack(alignment: .topLeading) {
                    ZStack(alignment: .topTrailing) {
                        PlayerWebViewWrapperView(url: playerUrl)
                        
                        // player close button for miniplayer
                        if playerStatus.isPlayerMinimised {
                            Button(action: {
                                PlayerWebView.shared.playerClose()
                            }, label: {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .padding(5)
                            })
                        }
                    }
                    .frame(width: playerStatus.isPlayerMinimised ? miniPlayerWidth : UIScreen.main.bounds.width, height: playerStatus.isPlayerMinimised ? miniPlayerHeight : UIScreen.main.bounds.height)
                    .cornerRadius(playerStatus.isPlayerMinimised ? 10 : 0)
                    .position(playerStatus.isPlayerMinimised ? location : CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2))
                    .gesture(
                        DragGesture().onChanged({ value in
                            var newLocation: CGPoint = value.location
                            
                            if value.location.x < miniPlayerPositionLeadingX {
                                newLocation.x = miniPlayerPositionLeadingX
                            }
                            if value.location.y < miniPlayerPositionLeadingY {
                                newLocation.y = miniPlayerPositionLeadingY
                            }
                            if value.location.x > miniPlayerPositionTrailingX  {
                                newLocation.x = miniPlayerPositionTrailingX
                            }
                            if value.location.y > miniPlayerPositionTrailingY  {
                                newLocation.y = miniPlayerPositionTrailingY
                            }
                            
                            self.location = newLocation
                        }))
                    .onTapGesture {
                        if playerStatus.isPlayerMinimised {
                            playerStatus.isPlayerMinimised = false
                            PlayerWebView.shared.evaluateJavascript("showUI()")
                            //PlayerWebView.webView.evaluateJavaScript("")
                        }
                    }
                    //.ignoresSafeArea()
                } //: Zstuck
            } //: Zstuck
        }
        
        
    }
}


