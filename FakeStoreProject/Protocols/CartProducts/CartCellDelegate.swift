
import Foundation

protocol CartCellDelegate {
    func addQuantity(product: CartProduct, completion: @escaping (Result<CartProduct,Error>) -> Void)

}
