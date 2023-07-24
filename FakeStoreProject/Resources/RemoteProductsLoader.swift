//
//  APIService.swift
//  FakeStoreProject
//
//  Created by Mac on 13/07/2023.
//

import Foundation

final class RemoteProductsLoader: ProductsLoader {
  
    let url = "https://fakestoreapi.com/products"
    
    func fetchProducts(completion: @escaping (Result<[Product],Error>) -> Void) {
        ///API call that decodes the JSON data into the Product struct
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            if error == nil {
                do {
                    let results = try JSONDecoder().decode([RemoteProduct].self, from: data!)
                    let products = results.map { remoteProduct in
                        Product(id: remoteProduct.id, title: remoteProduct.title, price: remoteProduct.price, description: remoteProduct.description, category: remoteProduct.category, image: remoteProduct.image, rating: remoteProduct.rating, isLiked: false)
                    }
                    completion(.success(products))
                }
                catch {
                    print("data could not be decoded: \(error)")
                }
            }
            
        }.resume()
    }
    
    
}
