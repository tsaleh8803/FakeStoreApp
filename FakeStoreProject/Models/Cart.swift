//
//  Cart.swift
//  FakeStoreProject
//
//  Created by Mac on 18/07/2023.
//

import Foundation

struct Cart: Codable {
    let id: Int
    let userId: Int
    let date: String
    let products: [cartProduct]
    
}

struct cartProduct: Codable {
    
    let productId: Int
    let quantity: Int
    
}
