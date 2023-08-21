
import Foundation
import UIKit

enum ProductsUIComposer {
    
    public static func make(with loader: ProductsLoader) -> UIViewController {
        let storyboard = UIStoryboard(name: "ProductsViewController", bundle: nil)
        let homeProductsVC = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        homeProductsVC.productsLoader = loader
        
        return homeProductsVC
    }
}
