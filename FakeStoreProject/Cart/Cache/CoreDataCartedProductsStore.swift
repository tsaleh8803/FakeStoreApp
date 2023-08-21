
import Foundation
import UIKit
import CoreData

final class CoreDataCartedProductsStore: AddProduct, DeleteProduct, CheckProduct, CartProductsLoader, ProductCellDelegate {
  
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func checkForProduct(product: Product) throws -> Bool {
        var count = 0
        
        try context.performAndWait {
            let request = MOCartProduct.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
            count = try context.count(for: request)
        }
        return count > 0
    }
    
    public func addProduct(product: Product) throws {
        
        guard try !checkForProduct(product: product) else {
            return
        }
        
        try context.performAndWait {
            let newCartProduct = MOCartProduct(context: context)
            newCartProduct.id = Int32(product.id)
            newCartProduct.title = product.title
            newCartProduct.category = product.category
            newCartProduct.price = product.price
            newCartProduct.desc = product.description
            newCartProduct.image = product.image
            try context.save()
        }
    }
    
    public func deleteProduct(product: Product) throws {
        try context.performAndWait {
            let request = MOCartProduct.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
            
            let productToDelete = try context.fetch(request).first
            productToDelete.map(context.delete)
            
            try context.save()
        }
    }
    
    func fetchCartProducts(completion: @escaping (Result<[CartProduct], Error>) -> Void) {
        let context = self.context
        
        context.perform {
            do {
                let cartedProductsFromCore = try context.fetch(MOCartProduct.fetchRequest())
                let cartedProducts = cartedProductsFromCore.map { product in
                    CartProduct(id: Int(product.id), title: product.title, price: product.price, description: product.description, category: product.category, image: product.image, rating: nil, isLiked: true, quantity: 1)
                }
                
                completion(.success(cartedProducts))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func addProductToCart(productCell: ProductCell, product: Product) {
        
        
        do {
            try self.addProduct(product: product)
            print("added product to cart!")
        }
        catch {
            
        }
    }
    
}
