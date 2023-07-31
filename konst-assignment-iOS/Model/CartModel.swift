//
//  CartModel.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 31/07/23.
//

import Foundation

class CartModel {
    var products: [CartProduct]?
    var totalPayPrice: String?
    var discount: String? {
        let sumOfProductPrices = products?.reduce(0) { (result, cartProduct) in
            if let productDiscount = cartProduct.discountedPrice {
                return result + productDiscount
            } else {
                return result
            }
        }
        return sumOfProductPrices?.description
    }
    var totalItamPrice: Int? {
        let sumOfProductPrices = products?.reduce(0) { (result, cartProduct) in
            if let productPrice = cartProduct.productPrice {
                return result + productPrice
            } else {
                return result
            }
        }
        return sumOfProductPrices
    }
}

class CartProduct {
    var productId: Int?
    var productName: String?
    var productPrice: Int?
    var discountPercentage: Double?
    var quantity: Int?
    var stock: Int?
    var discountedPrice: Double? {
        if let discount = discountPercentage {
            return (Double(productPrice ?? 0) * discount)/100
        }
        return nil
    }
    var image: String?
}
