//
//  ProductModel.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 28/07/23.
//

import Foundation

// MARK: - Products

struct ProductModel: Codable {
    var products: [Product]?
    var total: Int?
    var skip: Int?
    var limit: Int?
}
struct Product: Codable {
    var id: Int?
    var title, description: String?
    var price: Int?
    var discountPercentage, rating: Double?
    var stock: Int?
    var brand, category: String?
    var thumbnail: String?
    var images: [String]?
    
    // MARK: Custom properties
    var discountLabelText: String? {
        if let discount = self.discountPercentage {
            return "\(discount)% OFF"
        } else {
            return nil
        }
    }
}
