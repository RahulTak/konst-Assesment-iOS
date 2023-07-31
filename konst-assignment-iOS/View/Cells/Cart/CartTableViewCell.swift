//
//  CartTableViewCell.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 30/07/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var qtyIncreaseBtn: UIButton!
    @IBOutlet weak var qtyDecreaseBtn: UIButton!
    @IBOutlet weak var qtyBGView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    var cartProduct: CartProduct? {
        didSet {
            self.setupCell()
        }
    }
    
    var quantityUpdate: ((_ isIncrease: Bool?)->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        self.bgView.drawShadowOnCell()
        self.qtyBGView.drawShadowOnCell()
        self.qtyBGView.layer.borderColor = UIColor.black.cgColor
        self.qtyBGView.layer.borderWidth = 1
        self.productImg.download(from: cartProduct?.image ?? "")
        self.productName.text = cartProduct?.productName
        self.productQuantity.text = "\(cartProduct?.quantity ?? 0)"
        self.calulatePrice()
    }
    
    func calulatePrice() {
        if let discount = cartProduct?.discountPercentage {
            //(46*10.68)/100
            let discountPrice = (Double(self.cartProduct?.productPrice ?? 0) * discount)/100
            let priceString = discountPrice.localCurrency + " " + (cartProduct?.productPrice?.localCurrency ?? "")
            self.productPrice.text = priceString
            self.productPrice.setSubTextColor(pSubString: discountPrice.localCurrency, pColor: .lightGray)
        } else {
            self.productPrice.text = (cartProduct?.productPrice?.localCurrency ?? "")
        }
    }
    
    @IBAction func quantityIncrease(_ sender: UIButton) {
        self.quantityUpdate?(true)
    }
    @IBAction func quantityDecrease(_ sender: UIButton) {
        self.quantityUpdate?(false)
    }
    
    
}
