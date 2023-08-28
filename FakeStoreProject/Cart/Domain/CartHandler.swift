
import Foundation

class CartProductDecreaserHandler: CartProductQuantityChecker {
    
    private let decreaser: CartProductQuantityDecreaser
    private let remover: CartProductRemover
    
    init(decreaser: CartProductQuantityDecreaser , remover: CartProductRemover) {
        self.decreaser = decreaser
        self.remover = remover
    }
    
    func minusQuantity(product: CartProduct, completion: @escaping (DecreaseQuantityState) -> Void) {
        if product.quantity == 1 {
            remover.removeProduct(product: product) { error in
                if let error {
                    completion(.error(error))
                } else {
                    completion(.remove(product))
                }
            }
        } else {
            decreaser.decreaseQuantity(product: product) { result in
                switch result {
                case .success(let product):
                    completion(.update(product))
                case .failure(let failure):
                    completion(.error(failure))
                }
            }
        }
    }
}

enum DecreaseQuantityState {
    case update(CartProduct)
    case remove(CartProduct)
    case error(Error)
}
