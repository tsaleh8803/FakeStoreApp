//
//  LikedProduct.swift
//  FakeStoreProject
//
//  Created by Mac on 25/08/2023.
//

import Foundation

struct LikedProduct {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating?
    let isLiked: Bool
}
