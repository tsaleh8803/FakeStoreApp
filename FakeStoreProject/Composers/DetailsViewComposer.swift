
import Foundation
import UIKit

enum DetailsViewComposer {
    
    public static func createDetailsPage(product: Product) -> UIViewController {
        let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! DetailsViewController
        vc.product = product
        
        let store = CoreDataLikedProductsStore(context: CoreDataContext.context())
        let cart = CoreDataCartedProductsStore(context: CoreDataContext.context())
        vc.cartDelegate = cart
        vc.deleteDelegate = store
        vc.likeDelegate = store
        vc.checkerDelegate = store
        
        return vc
    }
}
