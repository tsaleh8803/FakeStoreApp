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
    
    var likedProductList = [LikedProduct]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDetails(product: product)
    }
    
    private func productDetails(product: Product) {
        titleLabel.text = product.title
        categoryLabel.text = product.category
        priceLabel.text = String(product.price)
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
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
        let buttonImage = likedButton.imageView?.image
        let heartImage = UIImage(named: "heart")
        
        if ((buttonImage?.isEqual(heartImage)) != nil){
            likedButton.setImage(UIImage(named: "pencil"), for: .normal)
            addLikedProduct(product: product)
            for i in 0..<likedProductList.count {
                print("Liked Product \(i): is Liked: \(self.product.isLiked)" + likedProductList[i].title!)
            }
        }
        else{
            likedButton.setImage(UIImage(named: "heart.fill"), for: .normal)
            deleteProduct(product: product)
        }
        
    }
    
    public func getAllProducts() {
       
        do {
            likedProductList = try context.fetch(LikedProduct.fetchRequest())
        }
        catch {
            
        }
       
    }
    public func addLikedProduct(product: Product) {
        let newLikedProduct = LikedProduct(context: context)
        newLikedProduct.title = product.title
        newLikedProduct.category = product.category
        newLikedProduct.price = product.price
        self.product.isLiked = true
        do {
            try context.save()
            getAllProducts()
        }
        catch {
            
        }
        
    }
    
    public func deleteProduct(product: Product) {
        let request = LikedProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", product.id)
        self.product.isLiked = false
        do {
            let savedProduct = try context.fetch(request).first
            savedProduct.map(context.delete)
            
        }
        catch {
            
        }
        do {
            try context.save()
            getAllProducts()
        }
        catch{
            
        }
    }
    
}
