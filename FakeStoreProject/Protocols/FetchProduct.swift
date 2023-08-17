//
//  FetchProducts.swift
//  FakeStoreProject
//
//  Created by Mac on 16/08/2023.
//

import Foundation

protocol FetchProduct {
    
    func checkIfProductLiked(product: Product) throws -> Bool
    
}
