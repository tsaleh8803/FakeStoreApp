//
//  FakeStoreTableViewCell.swift
//  FakeStoreProject
//
//  Created by Mac on 13/07/2023.
//

import UIKit

class ProductCell: UITableViewCell {
    
    public var delegate: ProductCellDelegate?
    
    var product: Product?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var likedLabel: UIImageView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addToCart(_ sender: Any) {
        if let product = product{
            self.delegate?.addProductToCart(productCell: self, product: product)
        }
    }

}

protocol ProductCellDelegate: AnyObject {
    func addProductToCart(productCell: ProductCell, product: Product)
}
