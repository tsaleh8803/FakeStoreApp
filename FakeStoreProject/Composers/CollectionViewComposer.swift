

import Foundation
import UIKit

enum CollectionViewComposer {
    
    public static func displayCollectionViewProducts(products: [Product]) -> UIViewController {
        let storyboard = UIStoryboard(name: "ProductCollectionViewController", bundle: nil)
       // let vc = storyboard.instantiateInitialViewController() as! DetailsViewController
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductCollectionViewController") as! ProductCollectionViewController
        vc.productsList = products
        return vc
    }
}
