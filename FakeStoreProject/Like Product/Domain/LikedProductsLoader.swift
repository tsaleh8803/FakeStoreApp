
import Foundation

protocol LikedProductsLoader {
    func fetchLikedProducts(completion: @escaping (Result<[LikedProduct],Error>) -> Void)
}
