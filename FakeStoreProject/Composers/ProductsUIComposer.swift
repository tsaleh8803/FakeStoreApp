
import UIKit
import Foundation


enum ProductsUIComposer {
    
    static func make(with loader: ProductsLoader) -> UIViewController {
        let storyboard = UIStoryboard(name: "ProductsViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        
        vc.productsLoader = loader
        vc.changeDisplay = { index, products in
            let productsView: ProductsView = index == 0 ? ProductsListUIComposer.make(with: products) : ProductsCollectionUIComposer.make(with: products)
            
            vc.display(productsView)
        }
        
        return vc
    }
}
