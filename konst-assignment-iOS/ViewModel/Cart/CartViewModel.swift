//
//  CartViewModel.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 31/07/23.
//

import Foundation
class CartViewModel {
    var cartmodel: CartModel? {
        didSet {
            self.reoloadData?()
        }
    }
    
    private var cartProducts: [CartProduct] = [CartProduct]() {
        didSet {
            self.reoloadData?()
        }
    }
    
    var reoloadData: (()->())?
    var showError: ((_ errorMsg: String?)->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var reloadTableViewAtIndex: ((_ indexPath: IndexPath?)->())?
    
    func getCartData(){
        showLoading?()
        CartNetwork.shared.getCart({ product, errorMsg in
            self.hideLoading?()
            if product != nil {
                if let cartProducts = product?.products {
                    self.createCell(cartProducts)
                }
                if let productData = product {
                    self.cartmodel = productData
                } else {
                    self.showError?("No product found")
                }
                self.reoloadData?()
            } else {
                self.showError?(errorMsg)
            }
        })
    }
    
    var numberOfCells: Int {
        return cartProducts.count
    }
    
    func getImageForCell( at indexPath: IndexPath ) -> CartProduct {
        return cartProducts[indexPath.row]
    }
    
    func createCell(_ products: [CartProduct]){
        self.cartProducts = products
    }
    
    func updateProductQuantity( at indexPath: IndexPath, isAdding: Bool) {
        
        showLoading?()
        DispatchQueue.global().async {
            sleep(1)
            if let stock = self.getImageForCell(at: indexPath).stock, stock == 0 {
                self.showError?("Product out of stock")
                return
            }
            if let cartModel = KonstSingletone.shared.cartProducts {
                cartModel.products?.forEach({ product in
                    if product.productId == self.getImageForCell(at: indexPath).productId {
                        if product.quantity == self.getImageForCell(at: indexPath).stock {
                            self.showError?("Products quantity too high")
                            return
                        }
                        if isAdding {
                            product.quantity = (product.quantity ?? 0) + 1
                        } else {
                            product.quantity = (product.quantity ?? 0) - 1
                        }
                    }
                    if (cartModel.products?[indexPath.row].quantity ?? 0) == 0 {
                        cartModel.products?.remove(at: indexPath.row)
                        self.cartmodel = cartModel
                        self.cartProducts = self.cartmodel?.products ?? []
                        self.reoloadData?()
                      return
                    }
                    
                    self.reloadTableViewAtIndex?(indexPath)
                })
            }
            self.hideLoading?()
        }
    }
}
