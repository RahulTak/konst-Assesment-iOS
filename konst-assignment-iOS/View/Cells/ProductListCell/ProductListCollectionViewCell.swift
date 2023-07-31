//
//  ProductListCollectionViewCell.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 29/07/23.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRatingImage: UIImageView!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productDiscountView: UIView!
    @IBOutlet weak var productDiscountLbl: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    // MARK: Properties
    var product: Product? {
        didSet {
            setupData()
        }
    }
    let topToBottomMask: [UIColor] = {
        return [UIColor.lightGray.withAlphaComponent(0.70), UIColor.orange.withAlphaComponent(0.60), UIColor.red.withAlphaComponent(0.60)]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupData()
    }
    
    func setupData() {
        self.cellBackgroundView.drawShadowOnCell()
        self.drawShadowOnCell()
        self.cellBackgroundView.clipsToBounds = true
        self.productDiscountView.setGradientBackground(self.topToBottomMask, radius: 0)
        if let imageUrlStr = product?.thumbnail, imageUrlStr != "" {
            self.productImage.download(from: imageUrlStr, contentMode: .scaleAspectFill)
        }
        self.productName.text = product?.title
        self.productDiscountLbl.text = product?.discountLabelText
        self.productDiscountView.isHidden = self.product?.discountPercentage == nil ? true : false
        self.productDiscountLbl.textColor = .white
        self.productRating.text = product?.rating?.description
        self.productPrice.text = (product?.price?.localCurrency ?? "")
        self.calulatePrice()
        
    }
    
    func calulatePrice() {
        if let discount = product?.discountPercentage {
            //(46*10.68)/100
            let discountPrice = (Double(self.product?.price ?? 0) * discount)/100
            let priceString = discountPrice.localCurrency + " " + (product?.price?.localCurrency ?? "")
            self.productPrice.text = priceString
            self.productPrice.setSubTextColor(pSubString: discountPrice.localCurrency, pColor: .lightGray)
        } else {
            self.productPrice.text = (product?.price?.localCurrency ?? "")
        }
    }
    
}
