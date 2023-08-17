//
//  CoreDataLikedProducts.swift
//  FakeStoreProject
//
//  Created by Mac on 16/08/2023.
//

import Foundation
import UIKit
import CoreData

final class CoreDataLikedProductsStore: LikeProduct, DeleteProduct, FetchProduct, ProductsLoader {
  
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func checkIfProductLiked(product: Product) throws -> Bool {
        var count = 0
        
        try context.performAndWait {
            let request = LikedProduct.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
            count = try context.count(for: request)
        }
        
        return count > 0
    }
    
    public func addLikedProduct(product: Product) throws {
        guard try !checkIfProductLiked(product: product) else {
            return
        }
        
        try context.performAndWait {
            let newLikedProduct = LikedProduct(context: context)
            newLikedProduct.id = Int32(product.id)
            newLikedProduct.title = product.title
            newLikedProduct.category = product.category
            newLikedProduct.price = product.price
            newLikedProduct.desc = product.description
            newLikedProduct.image = product.image
            
            
            try context.save()
        }
    }
    
    public func deleteProduct(product: Product) throws {
        try context.performAndWait {
            let request = LikedProduct.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
            
            let productToDelete = try context.fetch(request).first
            productToDelete.map(context.delete)
            
            try context.save()
        }
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let context = self.context
        
        context.perform {
            do {
                let likedProductsFromCore = try context.fetch(LikedProduct.fetchRequest())
                let likedProducts = likedProductsFromCore.map { product in
                    Product(id: Int(product.id), title: product.title, price: product.price, description: product.description, category: product.category, image: product.image, rating: nil, isLiked: true)
                }
                
                completion(.success(likedProducts))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
