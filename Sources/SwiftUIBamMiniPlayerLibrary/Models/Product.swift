//
//  Product.swift
//  SwiftUIBamMiniPlayer
//
//  Created by Kaori Persson on 2022-09-03.
//

import Foundation

public struct Product: Identifiable {
    public let id: UUID = UUID()
    let sku: String
    let title: String
    let url: String
}
