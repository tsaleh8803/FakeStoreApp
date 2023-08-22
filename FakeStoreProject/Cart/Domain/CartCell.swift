
import Foundation
import UIKit

class CartCell: UITableViewCell {
            
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var onIncreaseQuantity: (() -> Void)?
    var onDecreaseQuantity: (() -> Void)?
    
    @IBAction func increaseQuantity(_ sender: Any) {
        onIncreaseQuantity?()
        
    }
    
    @IBAction func decreaseQuantity(_ sender: Any) {
        onDecreaseQuantity?()
    }
}
