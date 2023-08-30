//
//  LikedProductCollectionViewCell.swift
//  FakeStoreProject
//
//  Created by Mac on 17/08/2023.
//

import Foundation
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var likedLabel: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        likedLabel.image = nil
    }
}

