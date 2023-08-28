//
//  LikedProductCollectionViewCell.swift
//  FakeStoreProject
//
//  Created by Mac on 17/08/2023.
//

import Foundation
import UIKit

class LikedProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
public func configure(for product: LikedProduct) {
        nameLabel.text = product.title
        priceLabel.text = String(product.price)
        productImageView.downloaded(from: URL(string: product.image)!)
    }
}

