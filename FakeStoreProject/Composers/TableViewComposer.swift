
import Foundation
import UIKit

enum ProductsUIComposer {
    
    public static func displayTableViewProducts(products: [Product]) -> UIViewController {

        let defaultView = UIStoryboard(name: "ProductListViewController", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        defaultView.checkerDelegate = CoreDataLikedProductsStore(context: CoreDataContext.context())
        defaultView.productList = products
        return defaultView
    }
}
