//
//  LikedProductsLoader.swift
//  FakeStoreProject
//
//  Created by Mac on 17/08/2023.
//

import Foundation
import UIKit

protocol LikedProductsRetriever {
    func retrieveLikedProducts() throws -> [Product]
}

// TODO: Remove this file
final class LikedProductsLoader: ProductsLoader {

    init() {
        
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        
    }
    
}
