//
//  LikedProductsLoader.swift
//  FakeStoreProject
//
//  Created by Mac on 17/08/2023.
//

import Foundation
import UIKit

final class MainPageProductsLoader: ProductsLoader {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        
    }
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        do {
            let likedProducts = try context.fetch(LikedProduct.fetchRequest())
            
        }
        catch {
            
        }
    }
    
}
