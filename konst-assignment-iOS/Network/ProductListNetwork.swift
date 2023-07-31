//
//  ProductListNetwork.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 29/07/23.
//

import Foundation

class ProductListNetwork {
    static let shared = ProductListNetwork()
    func getProducts( completion: @escaping (_ products: [Product]?, _ errorMsg: String? )->() ) {
        ApiClient.getDataFromServer { result in
            switch result {
            case .success(let apiResponse):
                guard let response = apiResponse, let productModel: ProductModel = parseJSON(data: response), let products = productModel.products else {
                    return completion(nil, "Parsing error")
                }
                completion(products, nil)
            case .failure(let error):
                print(error)
                completion(nil, error.localizedDescription)
            }
        }
    }
}
