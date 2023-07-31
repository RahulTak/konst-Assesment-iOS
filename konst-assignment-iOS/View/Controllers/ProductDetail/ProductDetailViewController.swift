//
//  ProductDetailViewController.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 30/07/23.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productRatingImg: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    var productDetailViewModel = ProductDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAllData()
    }
    @IBAction func addToCartTapped(_ sender: UIButton) {
        productDetailViewModel.addToCart()
    }
    
    var productId: Int? 
    
    func setupAllData() {
        initViewModel()
        setupVC()
    }
    
    func initViewModel(){
        
        productDetailViewModel.productId = productId
        productDetailViewModel.reoloadData = {
            DispatchQueue.main.async { self.reloadableVCData() }
        }
        productDetailViewModel.reloadCollectionView = { DispatchQueue.main.async { self.productImagesCollectionView.reloadData() } }
        productDetailViewModel.showError = { errMsg in
            DispatchQueue.main.async { self.showAlert(errMsg ?? "Ups, something went wrong.") }
        }
        productDetailViewModel.showLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
        }
        productDetailViewModel.hideLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
        productDetailViewModel.getProductData()
    }
    
    func setupVC() {
        self.productImagesCollectionView.delegate = self
        self.productImagesCollectionView.dataSource = self
        self.productImagesCollectionView.register(UINib(nibName: "ProductDetailImgCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailImgCollectionViewCell")
        self.addCartBarButton()
        self.addBackButton("Product Detail")
    }
    
    func reloadableVCData() {
        self.calulatePrice()
        self.productName.text = productDetailViewModel.product.title
        self.brandName.text = productDetailViewModel.product.brand
        self.productDescription.text = productDetailViewModel.product.description
        self.productRating.text = productDetailViewModel.product.rating?.description
    }
    
    func calulatePrice() {
        if let discount = productDetailViewModel.product.discountPercentage {
            //(46*10.68)/100
            let discountPrice = (Double(self.productDetailViewModel.product.price ?? 0) * discount)/100
            let discountPriceStr = "(" + (self.productDetailViewModel.product.discountLabelText ?? "") + ")"
            let priceString = discountPrice.localCurrency + " " + (productDetailViewModel.product.price?.localCurrency ?? "") + " " + discountPriceStr
            self.productPrice.text = priceString
            self.productPrice.setSubTextColor(pSubString: discountPrice.localCurrency, pColor: .systemGray)
            self.productPrice.setSubTextColor(pSubString: discountPriceStr , pColor: .systemOrange.withAlphaComponent(0.80), isStrike: false)
        } else {
            self.productPrice.text = (productDetailViewModel.product.price?.localCurrency ?? "")
        }
    }
    
}

// MARK: CollectionView
extension ProductDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailImgCollectionViewCell", for: indexPath) as? ProductDetailImgCollectionViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.productImage = productDetailViewModel.getImageForCell(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: UIScreen.main.bounds.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.productDetailViewModel.numberOfCells
    }
}
