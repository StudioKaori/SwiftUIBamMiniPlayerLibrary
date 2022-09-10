//
//  PlayerStatus.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-03.
//

import SwiftUI

@available(iOS 13.0, *)
public final class PlayerStatus: ObservableObject {
    // MARK: - Properties
    public @Published var isPlayerViewVisible: Bool = false
    public @Published var isPlayerMinimised: Bool = false
    public @Published var showID: String = ""
    
    // MARK: - Singleton instance
    public static let shared = PlayerStatus()
    private init() {}
}
