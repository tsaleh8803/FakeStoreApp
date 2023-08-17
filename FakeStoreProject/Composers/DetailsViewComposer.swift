//
//  DetailViewComposer.swift
//  FakeStoreProject
//
//  Created by Mac on 17/08/2023.
//

import Foundation
import UIKit

enum DetailsViewComposer {
    
    public static func createDetailsPage(product: Product) -> DetailsViewController {
        let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! DetailsViewController
        vc.product = product
        
        let store = CoreDataLikedProductsStore(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        vc.deleteDelegate = store
        vc.likeDelegate = store
        vc.checkerDelegate = store
        
        return vc
    }
}
