//
//  UIViewController+Extension.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 29/07/23.
//

import UIKit

extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func addCartBarButton() {
        var btnsArray = [UIBarButtonItem]()
        let size = CGSize(width: 32, height: 32)
        
        let button = UIButton(type: .system)
        button.tag = 1001
        button.setImage(UIImage(named: "Cart"), for: .normal)
        button.addTarget(self, action: #selector(didTapCart(sender:)), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.navigationItem.setRightBarButtonItems([menuBarItem], animated: true)
        
    }
    
    @objc func didTapCart(sender : Any) {
        self.navigateToCart()
    }
    
    func navigateToCart() {
        guard let cartVC = mainStoryboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else { return }
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    func addBackButton(_ title: String, image : String = "back"){
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 44))
        let img = UIImage(named: image)
        let imageview = UIImageView(frame: CGRect(x: 0, y: 11, width: 20, height: 20))
        imageview.image = img
        imageview.contentMode = .scaleAspectFit
        leftView.addSubview(imageview)
        imageview.tintColor = .black
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imageview.addGestureRecognizer(tap)
        imageview.isUserInteractionEnabled = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        self.title = title
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIView {
    func drawShadowOnCell(_ radius: CGFloat = 10, shadowColor: UIColor = .black, opacity: Float = 0.15, shadowRadius: CGFloat = 3 ) {
        let layer = self.layer
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.cornerRadius = radius
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = opacity
        layer.shadowRadius = shadowRadius
    }
    
    // - Parameters:
    // - colors: gradient colors
    // - opacity: opacity
    // - direction: gradient direction
    // - radius: radius
    func setGradientBackground(_ colors: [UIColor], opacity: Float = 1, direction: GradientColorDirection = .horizontal, radius: CGFloat = 25) {
        if let sublayers = self.layer.sublayers {
            for item in sublayers {
                if item is CAGradientLayer {
                    item.removeFromSuperlayer()
                }
            }
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.opacity = opacity
        gradientLayer.colors = colors.map { $0.cgColor }
        
        if case .horizontal = direction {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        }
        
        gradientLayer.bounds = self.bounds
        gradientLayer.cornerRadius = radius
        gradientLayer.anchorPoint = CGPoint.zero
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    enum GradientColorDirection {
        case vertical
        case horizontal
    }
    
    func widthForView(width: CGFloat? = nil, text: String, font: UIFont) -> CGFloat {
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width ?? CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.width
    }
}
