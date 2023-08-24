
import Foundation

protocol CartTotalDelegate {
    func calculateTotal(cartProducts: [CartProduct]) -> Double
}
