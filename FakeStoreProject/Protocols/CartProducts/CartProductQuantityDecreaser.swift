//
//  CartProductQuantityDecreaser.swift
//  FakeStoreProject
//
//  Created by Mac on 24/08/2023.
//

import Foundation

protocol CartProductQuantityChecker {
    func minusQuantity(product: CartProduct, completion: @escaping (DecreaseQuantityState) -> Void)
}

protocol CartProductQuantityDecreaser {
    func decreaseQuantity(product: CartProduct, completion: (Result<CartProduct,Error>) -> Void)
}
