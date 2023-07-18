//
//  DetailsViewController.swift
//  FakeStoreProject
//
//  Created by Mac on 14/07/2023.
//

import UIKit

class DetailsViewController: UITableViewController {

    var product: Product!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        productDetails(product: product)
    }
    
    private func productDetails(product: Product) {
        titleLabel.text = product.title
        categoryLabel.text = product.category
        priceLabel.text = String(product.price)
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed placerat mauris, eget semper orci. Maecenas ut ligula fringilla, volutpat elit non, rutrum nunc. "//product.description
        productImage.downloaded(from: URL(string: product.image)!)
    }
}
