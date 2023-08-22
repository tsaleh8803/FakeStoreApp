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
    var isLiked: Bool // TODO: Remove isLiked
    
    init(id: Int, title: String, price: Double, description: String, category: String, image: String, rating: Rating?, isLiked: Bool) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rating = rating
        self.isLiked = isLiked
    }
    
    init(cartProduct: CartProduct) {
        self.id = cartProduct.id
        self.title = cartProduct.title
        self.price = cartProduct.price
        self.description = cartProduct.description
        self.category = cartProduct.category
        self.image = cartProduct.image
        self.rating = cartProduct.rating
        self.isLiked = cartProduct.isLiked
    }
}

