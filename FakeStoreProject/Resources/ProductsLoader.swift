//
//  ProductsLoader.swift
//  FakeStoreProject
//
//  Created by Mac on 14/07/2023.
//

import Foundation


protocol ProductsLoader {
    func fetchProducts(completion: @escaping (Result<[Product],Error>) -> Void)
}
