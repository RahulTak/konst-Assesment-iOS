//
//  CartNetwork.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 31/07/23.
//

import Foundation

class CartNetwork {
    static let shared = CartNetwork()
    func getCart(_ completion: @escaping (_ product: CartModel?, _ errorMsg: String? )->() ) {
        DispatchQueue.global().async {
            sleep(3)
            completion(KonstSingletone.shared.cartProducts, nil)
        }
    }
}
