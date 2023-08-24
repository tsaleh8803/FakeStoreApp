
import Foundation
import UIKit
import CoreData

final class CoreDataCartedProductsStore: CartProductsLoader, ProductToCartAdder, CartCellDelegate, CartTotalDelegate, CartProductQuantityDecreaser, CartProductRemover {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchCartProducts(completion: @escaping (Result<[CartProduct], Error>) -> Void) {
        let context = self.context
        
        context.perform {
            completion(Result {
                try context
                    .fetch(MOCartProduct.fetchRequest())
                    .map { $0.toCartProduct() }
            })
        }
    }

    func addProductToCart(product: Product, quantity: Int, completion: @escaping (Result<CartProduct,Error>) -> Void) {
        let context = self.context
        context.perform {
            completion(Result {
                let request = MOCartProduct.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
                let managedCartProduct = try context.fetch(request).first
                
                if let managedCartProduct {
                    managedCartProduct.quantity += Int32(quantity)
                    try context.save()
                                        
                    return managedCartProduct.toCartProduct()
                }
                
                let newCartProduct = MOCartProduct(context: context)
                newCartProduct.fill(with: product)
                newCartProduct.quantity = Int32(quantity)
                try context.save()
                
                return newCartProduct.toCartProduct()
            })
        }
    }
    
    func addQuantity(product: CartProduct, completion: @escaping (Result<CartProduct,Error>) -> Void) {
        let productNew = Product(cartProduct: product)
        addProductToCart(product: productNew,quantity: 1,completion: completion)
    }
    
    func removeProduct(product: CartProduct, completion: @escaping (Error?) -> Void) {
        do {
            try context.performAndWait {
                let context = self.context
                let request = MOCartProduct.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
                
                let productToDelete = try context.fetch(request).first
                productToDelete.map(context.delete)
                
                try context.save()
                completion(.none)
            }
        } catch {
            completion(error)
        }
    }
    
    func decreaseQuantity(product: CartProduct, completion: (Result<CartProduct,Error>) -> Void) {
        let request = MOCartProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
        do {
            guard let managedCartProduct = try context.fetch(request).first else {
                return completion(.failure(ProductDoesNotExist()))
            }
            
            if managedCartProduct.quantity > 1 {
                managedCartProduct.quantity -= 1
            }
            try context.save()
            completion(.success(managedCartProduct.toCartProduct()))
        }
        catch {
            
        }
        
    }
  
    
    func calculateTotal(cartProducts: [CartProduct]) -> Double {
        var total = 0.0
        for product in cartProducts {
            total += (product.price * Double(product.quantity))
        }
        
        return Double(round(total * 100) / 100.0)
    }
    
}

struct ProductDoesNotExist: Error {
    
}

extension MOCartProduct {
    func fill(with product: Product) {
        id = Int32(product.id)
        title = product.title
        category = product.category
        price = product.price
        desc = product.description
        image = product.image
        quantity = 1
    }
}

extension MOCartProduct {
    func toCartProduct() -> CartProduct {
        CartProduct(id: Int(id), title: title, price: price, description: desc, category: category, image: image, rating: nil, isLiked: true, quantity: Int(quantity))
    }
    
}
//
//extension MOCartProduct {
//    static func find(by id: String) -> MOCartProduct? {
//        
//    }
//}
