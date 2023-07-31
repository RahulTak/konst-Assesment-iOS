//
//  konstSingletone.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 31/07/23.
//

// this is for the storing the cart data and getting
// it for the cart view api will store it into userdefaults also
import Foundation

class KonstSingletone {
    static let shared: KonstSingletone = KonstSingletone()
    
    var cartProducts: CartModel?
}
