
import Foundation
import UIKit
import CoreData

final class CoreDataLikedProductsStore: ProductLiker, ProductDisliker, CheckProduct, LikedProductsLoader {
  
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func checkForProduct(product: Product) throws -> Bool {
        var count = 0
        
        try context.performAndWait {
            let request = MOLikedProduct.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
            count = try context.count(for: request)
        }
        return count > 0
    }
    
    public func likeProduct(product: Product) throws {
        guard try !checkForProduct(product: product) else {
            return
        }
        
        try context.performAndWait {
            let newLikedProduct = MOLikedProduct(context: context)
            newLikedProduct.id = Int32(product.id)
            newLikedProduct.title = product.title
            newLikedProduct.category = product.category
            newLikedProduct.price = product.price
            newLikedProduct.desc = product.description
            newLikedProduct.image = product.image
            
            try context.save()
        }
    }
    
    public func dislikeProduct(product: Product) throws {
        try context.performAndWait {
            let request = MOLikedProduct.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
            
            let productToDelete = try context.fetch(request).first
            productToDelete.map(context.delete)
            
            try context.save()
        }
    }
    
    func fetchLikedProducts(completion: @escaping (Result<[LikedProduct], Error>) -> Void) {
        let context = self.context
        
        context.perform {
            completion(Result {
                try context
                    .fetch(MOLikedProduct.fetchRequest())
                    .map { $0.toLikedProduct() }
            })
        }
    }
}
extension MOLikedProduct {
    func toLikedProduct() -> LikedProduct {
        LikedProduct(id: Int(id), title: title, price: price, description: desc, category: category, image: image, rating: nil, isLiked: true)
    }
    
}
