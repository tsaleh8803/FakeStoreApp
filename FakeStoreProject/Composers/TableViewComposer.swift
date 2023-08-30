
import Foundation
import UIKit

enum ProductsListUIComposer {
    
    public static func make(with products: [Product]) -> ProductsView {
        let defaultView = UIStoryboard(name: "ProductListViewController", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        defaultView.checkerDelegate = CoreDataLikedProductsStore(context: CoreDataContext.context())
//        defaultView.products = products
        
        return defaultView
    }
}
