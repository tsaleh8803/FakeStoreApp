//
//  LikedProductsViewController.swift
//  FakeStoreProject
//
//  Created by Mac on 20/07/2023.
//

import UIKit
import CoreData

final class LikedProductsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let likedProducts = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        title = "Liked"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            let likedProducts = try context.fetch(LikedProduct.fetchRequest())
            for i in 0..<likedProducts.count {
                print("liked product \(i): " + likedProducts[i].title!)
            }
        }
        catch {
            
        }
    }
}
