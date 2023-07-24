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
        do {
            let likedProducts = try context.fetch(LikedProduct.fetchRequest())
        }
        catch {
            
        }
        
        title = "Liked"
    }
}
