//
//  ProductDetailViewModel.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 30/07/23.
//

import Foundation

class ProductDetailViewModel {
    var product: Product = Product() {
        didSet {
            self.reoloadData?()
        }
    }
    
    private var productImages: [String] = [String]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    var productId: Int?
    
    var reloadCollectionView: (()->())?
    var reoloadData: (()->())?
    var showError: ((_ errorMsg: String?)->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    func getProductData(){
        showLoading?()
        ProductDetailNetwork.shared.getProduct(productId ?? 0, completion: { product, errorMsg in
            self.hideLoading?()
            if product != nil {
                if let images = product?.images {                
                    self.createCell(images)
                }
                if let productData = product {
                    self.product = productData
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
        return productImages.count
    }
    
    func getImageForCell( at indexPath: IndexPath ) -> String {
        return productImages[indexPath.row]
    }
    
    func createCell(_ imagesArr: [String]){
        self.productImages = imagesArr
    }
    
    func addToCart() {
        showLoading?()
        DispatchQueue.global().async {
            sleep(3)
            if let stock = self.product.stock, stock == 0 {
                self.showError?("Product out of stock")
                return
            }
            if let cartModel = KonstSingletone.shared.cartProducts, (cartModel.products?.count ?? 0) != 0 {
                cartModel.products?.forEach({ product in
                    if product.productId == self.product.id {
                        if product.quantity == self.product.stock {
                            self.showError?("Products quantity too high")
                            return
                        }
                        product.quantity = (product.quantity ?? 0) + 1
                    }
                })
            } else {
                let cartM = CartModel()
                let cartProduct = CartProduct()
                cartProduct.productId = self.product.id
                cartProduct.productName = self.product.title
                cartProduct.productPrice = self.product.price
                cartProduct.discountPercentage = self.product.discountPercentage
                cartProduct.quantity = 1
                cartProduct.stock = self.product.stock
                cartProduct.image = self.product.thumbnail
                cartM.products = [cartProduct]
                KonstSingletone.shared.cartProducts = cartM
            }
            self.hideLoading?()
        }
    }
}
