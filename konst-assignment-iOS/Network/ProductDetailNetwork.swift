//
//  ProductDetailNetwork.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 30/07/23.
//

import Foundation

class ProductDetailNetwork {
    static let shared = ProductDetailNetwork()
    func getProduct(_ id: Int, completion: @escaping (_ product: Product?, _ errorMsg: String? )->() ) {
        ApiClient.getDataFromServer { result in
            switch result {
            case .success(let apiResponse):
                guard let response = apiResponse, let productModel: ProductModel = parseJSON(data: response), let products = productModel.products else {
                    return completion(nil, "Parsing error")
                }
                var product: Product?
                for prod in products where prod.id == id {
                    product = prod
                }
                completion(product, product == nil ? "No product found" : nil)
            case .failure(let error):
                print(error)
                completion(nil, error.localizedDescription)
            }
        }
    }
}
