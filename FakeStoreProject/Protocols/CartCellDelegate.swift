
import Foundation

protocol CartCellDelegate {
    func addQuantity(product: CartProduct, completion: @escaping (Result<CartProduct,Error>) -> Void)
    func minusQuantity(product: CartProduct, completion: @escaping (Result<CartProduct,Error>) -> Void)
    func removeProduct(product: CartProduct) throws
}

