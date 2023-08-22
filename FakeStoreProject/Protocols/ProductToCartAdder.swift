
import Foundation


protocol ProductToCartAdder {
    func addProductToCart(product: Product, completion: @escaping (Result<CartProduct,Error>) -> Void)
}
