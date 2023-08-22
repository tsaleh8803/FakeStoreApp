
import Foundation
import UIKit

enum ProductsUIComposer {
    
    public static func make(with loader: ProductsLoader) -> UIViewController {
        let storyboard = UIStoryboard(name: "ProductsViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        vc.productsLoader = loader
        vc.checkerDelegate = CoreDataLikedProductsStore(context: CoreDataContext.context())
        
        return vc
    }
}
