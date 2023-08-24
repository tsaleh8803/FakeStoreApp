//
//  CartProductRemover.swift
//  FakeStoreProject
//
//  Created by Mac on 24/08/2023.
//

import Foundation


protocol CartProductRemover {
    func removeProduct(product: CartProduct, completion: @escaping (Error?) -> Void)
}
