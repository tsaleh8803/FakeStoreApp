//
//  DetailsViewController.swift
//  FakeStoreProject
//
//  Created by Mac on 14/07/2023.
//

import UIKit
import CoreData


class DetailsViewController: UIViewController {

    var product: Product!

    var defaultQuantityForCart = 1
    
    var productIndex: Int?
    
    public var cartDelegate: ProductToCartAdder?
    public var likeDelegate: ProductLiker?
    public var deleteDelegate: ProductDisliker?
    public var checkerDelegate: CheckProduct?
    
    let heartImage = UIImage(systemName: "heart")
    let heartImageFilled = UIImage(systemName: "heart.fill")

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var increaseQuantityButton: UIButton!
    @IBOutlet weak var decreaseQuantityButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDetails(product: product)
        do{
            if try (checkerDelegate!.checkForProduct(product: product)) {
                likedButton.setImage(heartImageFilled, for: .normal)
            }
        }
        catch {
            
        }
    }

    private func productDetails(product: Product) {
        titleLabel.text = product.title
        categoryLabel.text = product.category
        priceLabel.text = "$\(String(product.price))"
        descriptionTextView.text = product.description
        productImage.downloaded(from: URL(string: product.image)!)
        quantityLabel.text = String(defaultQuantityForCart)
    }
    
    @IBAction func goToNextProduct(_ sender: Any) {

    }
    
    @IBAction func goToPreviousProduct(_ sender: Any) {
        
    }

    @IBAction func quantityIncreaseButtonPressed(_ sender: Any) {
        defaultQuantityForCart += 1
        quantityLabel.text = String(defaultQuantityForCart)
    }
    
    @IBAction func quantityDecreaseButtonPressed(_ sender: Any) {
        if defaultQuantityForCart > 1 {
            defaultQuantityForCart -= 1
            quantityLabel.text = String(defaultQuantityForCart)
        }
        
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {

        do {
            if try (!checkerDelegate!.checkForProduct(product: product)) {
                //product.isLiked = true
                likedButton.setImage(heartImageFilled, for: .normal)
                do {
                    try likeDelegate?.likeProduct(product: product)
                }
                catch{
            
                }
            }
            else {
                //product.isLiked = false
                likedButton.setImage(heartImage,for: .normal)
                do {
                    try deleteDelegate?.dislikeProduct(product: product)
                }
                catch{
                    
                }
            }
        }
        catch {
            
        }
    }

    
    @IBAction func addButtonPressed(_ sender: Any ) {
        cartDelegate?.addProductToCart(product: product,quantity: defaultQuantityForCart, completion: { result in
            switch result {
            case .success(_):
                print("")
            case .failure(_):
                print("")
            }
        })
    }
}
