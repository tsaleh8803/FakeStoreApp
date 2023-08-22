//
//  FakeStoreTableViewCell.swift
//  FakeStoreProject
//
//  Created by Mac on 13/07/2023.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var likedLabel: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImage.image = nil
        likedLabel.image = UIImage(systemName: "heart")
    }
}
