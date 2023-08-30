

import Foundation
import UIKit

enum ProductsCollectionUIComposer {
    
    public static func make(with products: [Product]) -> ProductsView {
        let storyboard = UIStoryboard(name: "ProductCollectionViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductCollectionViewController") as! ProductCollectionViewController
//        vc.products = products
        vc.checkerDelegate = CoreDataLikedProductsStore(context: CoreDataContext.context())
        return vc
    }
}
