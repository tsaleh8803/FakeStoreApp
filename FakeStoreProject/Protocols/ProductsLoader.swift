
import Foundation

protocol ProductsLoader {
    func fetchProducts(completion: @escaping (Result<[Product],Error>) -> Void)
    
}
