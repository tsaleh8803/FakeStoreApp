
import Foundation


protocol ProductToCartAdder {
    func addProductToCart(product: Product,quantity: Int, completion: @escaping (Result<CartProduct,Error>) -> Void)
}
