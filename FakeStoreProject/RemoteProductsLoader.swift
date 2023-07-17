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
                    let results = try JSONDecoder().decode([Product].self, from: data!)
                    completion(.success(results))
                }
                catch {
                    print("data could not be decoded: \(error)")
                }
            }
            
        }.resume()
    }
    
    
}
