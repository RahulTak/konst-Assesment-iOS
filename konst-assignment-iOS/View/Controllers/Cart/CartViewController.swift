//
//  CartViewController.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 30/07/23.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeOrderBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var toPayPrice: UILabel!
    var cartViewModel = CartViewModel()
    
    override func viewDidLoad() {
        self.setupData()
    }
    
    func setupData() {
        initViewModel()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        self.title = "Cart"
        self.toPayPrice.text = cartViewModel.cartmodel?.totalItamPrice?.localCurrency
        self.addBackButton("Cart")
    }
    
    func initViewModel(){
        
        cartViewModel.reoloadData = {
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                if self.cartViewModel.numberOfCells == 0 {
                    self.showAlert("Cart is Empty")
                }
            }
        }
        cartViewModel.showError = { errMsg in
            DispatchQueue.main.async { self.showAlert(errMsg ?? "Cart is Empty") }
        }
        cartViewModel.showLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
        }
        cartViewModel.hideLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
        
        cartViewModel.reloadTableViewAtIndex = { indexPath in
            DispatchQueue.main.async {            
                if let index = indexPath {
                    self.tableView.reloadRows(at: [index], with: .automatic)
                }
            }
            
        }
        cartViewModel.getCartData()
    }
    
    @IBAction func placeOrderTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            sleep(1)
            self.showAlert("Order Placed Succesfully!")
        }
    }
    
}

// MARK: Table View
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        cell.cartProduct = cartViewModel.getImageForCell(at: indexPath)
        cell.quantityUpdate = { isIncrease in
            if let isUpdating = isIncrease {
                self.cartViewModel.updateProductQuantity(at: indexPath, isAdding: isUpdating)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
