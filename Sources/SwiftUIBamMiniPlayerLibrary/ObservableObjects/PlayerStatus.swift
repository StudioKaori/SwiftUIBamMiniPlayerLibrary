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
    @Published public var isPlayerViewVisible: Bool = false
    @Published public var isPlayerMinimised: Bool = false
    @Published public var showID: String = ""
    
    // MARK: - Singleton instance
    public static let shared = PlayerStatus()
    private init() {}
}
