//
//  CoreDataLikedProducts.swift
//  FakeStoreProject
//
//  Created by Mac on 16/08/2023.
//

import Foundation
import UIKit
import CoreData

final class CoreDataLikedProductsStore: LikeProduct, DeleteProduct, FetchProduct {
  
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func checkIfProductLiked(product: Product) -> Bool {
        let request = LikedProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
        var count = 0
        do {
            count = try context.count(for: request)
        }
        catch {
            
        }
        if count >= 1 {
            return true
        }
        return false
    }
    
    public func addLikedProduct(product: Product) {
        if !checkIfProductLiked(product: product) {
            let newLikedProduct = LikedProduct(context: context)
            newLikedProduct.id = Int32(product.id)
            newLikedProduct.title = product.title
            newLikedProduct.category = product.category
            newLikedProduct.price = product.price
            newLikedProduct.desc = product.description
            do {
                try context.save()
            }
            catch {
                
            }
        }
        else {
            return
        }
        
    }
    
    public func deleteProduct(product: Product) {
        let request = LikedProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))

        do {
            let productToDelete = try context.fetch(request).first
            productToDelete.map(context.delete)
            try context.save()
        }
        catch{
            
        }
    }
}
