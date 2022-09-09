//
//  ProductPageView.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-01.
//

import SwiftUI

@available(iOS 13.0, *)
struct ProductPageView: View {
    // MARK: - Properties
    @StateObject private var playerMessageHandler = PlayerMessageHandler.shared
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text("Product SKU: " + playerMessageHandler.currentProduct.sku)
                .padding()
            Text("Product Title: " + playerMessageHandler.currentProduct.title)
                .padding()
            Text("Product URL: " + playerMessageHandler.currentProduct.url)
                .padding()
        }
        
    }
}

