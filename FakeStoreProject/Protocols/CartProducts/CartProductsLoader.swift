
import Foundation

protocol CartProductsLoader {
    func fetchCartProducts(completion: @escaping (Result<[CartProduct],Error>) -> Void)
    
}
