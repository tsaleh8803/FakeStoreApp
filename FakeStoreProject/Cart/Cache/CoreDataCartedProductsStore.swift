
import Foundation
import UIKit
import CoreData

final class CoreDataCartedProductsStore: CartProductsLoader, ProductToCartAdder, CartCellDelegate {
  
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
    
    func addProductToCart(product: Product, completion: @escaping (Result<CartProduct,Error>) -> Void) {
        let context = self.context
        context.perform {
            completion(Result {
                let request = MOCartProduct.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
                let managedCartProduct = try context.fetch(request).first
                
                if let managedCartProduct {
                    managedCartProduct.quantity += 1
                    try context.save()
                                        
                    return managedCartProduct.toCartProduct()
                }
                
                let newCartProduct = MOCartProduct(context: context)
                newCartProduct.fill(with: product)
                try context.save()
                
                return newCartProduct.toCartProduct()
            })
        }
    }
    
    func addQuantity(product: CartProduct, completion: @escaping (Result<CartProduct,Error>) -> Void) {
        let productNew = Product(cartProduct: product)
        addProductToCart(product: productNew, completion: completion)
    }

    func minusQuantity(product: CartProduct, completion: @escaping (Result<CartProduct,Error>) -> Void) {
        let context = self.context
        context.perform {
            completion(Result {
                let request = MOCartProduct.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", NSNumber(value: product.id))
                
                guard let managedCartProduct = try context.fetch(request).first else {
                    throw ProductDoesNotExists()
                }
                
                managedCartProduct.quantity -= 1
                try context.save()
                
                return managedCartProduct.toCartProduct()
            })
        }
    }
    
}

struct ProductDoesNotExists: Error {}

extension MOCartProduct {
    func fill(with product: Product) {
        id = Int32(product.id)
        title = product.title
        category = product.category
        price = product.price
        desc = product.description
        image = product.image
    }
}

extension MOCartProduct {
    func toCartProduct() -> CartProduct {
        CartProduct(id: Int(id), title: title, price: price, description: description, category: category, image: image, rating: nil, isLiked: true, quantity: Int(quantity))
    }
    
}
