//
//  DetailsViewController.swift
//  FakeStoreProject
//
//  Created by Mac on 14/07/2023.
//

import UIKit

class DetailsViewController: UIViewController {

    var product: Product?
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDetails(product: product)
    }
    
    private func productDetails(product: Product?){
        if let selectedProduct = product {
            titleLabel.text = selectedProduct.title
            categoryLabel.text = selectedProduct.category
            priceLabel.text = String(selectedProduct.price)
            descriptionLabel.text = selectedProduct.description
            productImage.downloaded(from: URL(string: selectedProduct.image)!)
            ratingLabel.text = String(selectedProduct.rating.rate) + ", " + String(selectedProduct.rating.count)
        }
        
        
    }

}
