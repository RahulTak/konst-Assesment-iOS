//
//  ProductDetailImgCollectionViewCell.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 30/07/23.
//

import UIKit

class ProductDetailImgCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!

    var productImage: String? {
        didSet {
            self.setupCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupCell() {
        self.imgView.download(from: productImage ?? "")
    }

}
