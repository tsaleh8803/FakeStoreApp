
import Foundation
import UIKit

enum CartViewComposer {
    
    public static func createCartPage(with loader: CartProductsLoader) -> UIViewController {
        let storyboard = UIStoryboard(name: "CartViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.cartProductsLoader = loader
        return vc
    }
}
