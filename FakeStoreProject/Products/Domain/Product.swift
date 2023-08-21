//
//
//  Product.swift
//  FakeStoreProject
//
//  Created by Mac on 13/07/2023.
//

import Foundation

struct Product {
    
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating?
    var isLiked: Bool
}

