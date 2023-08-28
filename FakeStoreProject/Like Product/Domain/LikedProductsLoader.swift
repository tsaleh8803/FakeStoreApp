
import Foundation

protocol LikedProductsLoader {
    func fetchLikedProducts(completion: @escaping (Result<[Product],Error>) -> Void)
}
