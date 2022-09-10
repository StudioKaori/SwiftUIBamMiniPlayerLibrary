//
//  WebViewMessageHandler.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-06.
//

import SwiftUI

@available(iOS 13.0, *)
public final class PlayerMessageHandler: ObservableObject {
    // MARK: - Properties
    public @Published var isChildViewVisible: Bool = false
    public @Published var currentProduct: Product = Product(sku: "", title: "", url: "")
    
    // MARK: - Singleton instance
    public static let shared = PlayerMessageHandler()
    private init() {}
}

@available(iOS 13.0, *)
extension PlayerMessageHandler: MessageHandlerDelegate { 
    func playerProductTapped(productData: Product) {
        PlayerMessageHandler.shared.currentProduct = productData
        PlayerMessageHandler.shared.isChildViewVisible = true
    }
}
