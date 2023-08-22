//
//  DetailsViewController.swift
//  FakeStoreProject
//
//  Created by Mac on 14/07/2023.
//

import UIKit
import CoreData


class DetailsViewController: UITableViewController {

    var product: Product!
    
    var likedProductList = [MOLikedProduct]()
    
    public var cartDelegate: ProductToCartAdder?
    public var likeDelegate: ProductLiker?
    public var deleteDelegate: DeleteProduct?
    public var checkerDelegate: CheckProduct?
    
    let heartImage = UIImage(systemName: "heart")
    let heartImageFilled = UIImage(systemName: "heart.fill")

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
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
        descriptionLabel.text = product.description
        productImage.downloaded(from: URL(string: product.image)!)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {

        do {
            if try (!checkerDelegate!.checkForProduct(product: product)) {
                product.isLiked = true
                likedButton.setImage(heartImageFilled, for: .normal)
                do {
                    try likeDelegate?.likeProduct(product: product)
                }
                catch{
            
                }
            }
            else {
                product.isLiked = false
                likedButton.setImage(heartImage,for: .normal)
                do {
                    try deleteDelegate?.deleteProduct(product: product)
                }
                catch{
                    
                }
            }
        }
        catch {
            
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any ) {
        
    }
}
