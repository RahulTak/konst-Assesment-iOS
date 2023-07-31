//
//  File.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 28/07/23.
//

import Foundation

class ProductListViewModel {
    var products: [Product] = [Product]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    var reloadCollectionView: (()->())?
    var showError: ((_ errorMsg: String?)->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    private var cellViewModels: [Product] = [Product]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    func getData(){
        showLoading?()
        ProductListNetwork.shared.getProducts { products, errorMsg in
            self.hideLoading?()
            if products != nil {
                self.createCell(products!)
                self.reloadCollectionView?()
            } else {
                self.showError?(errorMsg)
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getModelForCell( at indexPath: IndexPath ) -> Product {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(_ products: [Product]){
        self.products = products
        self.cellViewModels = products

    }
}

