//
//  ViewController.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 28/07/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var productListViewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAllData()
    }
    
    func setupAllData() {
        initViewModel()
        setCollectionView()
        self.addCartBarButton()
    }
    
    func setCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ProductListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCollectionViewCell")
    }
    
    func initViewModel(){
        productListViewModel.reloadCollectionView = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
            }
        }
        productListViewModel.showError = { errMsg in
            DispatchQueue.main.async { self.showAlert(errMsg ?? "Ups, something went wrong.") }
        }
        productListViewModel.showLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
        }
        productListViewModel.hideLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
        productListViewModel.getData()
    }
}

// MARK: CollectionView
extension ProductListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as? ProductListCollectionViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        let cellVM = productListViewModel.getModelForCell( at: indexPath )
        cell.product = cellVM
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2-10, height: collectionView.frame.height/3)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.productListViewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController else { return }
        productDetailVC.productId = self.productListViewModel.getModelForCell(at: indexPath).id
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
}
