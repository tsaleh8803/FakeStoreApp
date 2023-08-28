
import Foundation
import UIKit

enum DetailsViewComposer {
    
    public static func createDetailsPage(product: Product, index: Int) -> UIViewController {
        let storyboard = UIStoryboard(name: "DetailsViewController", bundle: nil)
       // let vc = storyboard.instantiateInitialViewController() as! DetailsViewController
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.product = product
        
        let likedStore = CoreDataLikedProductsStore(context: CoreDataContext.context())
        let cartStore = CoreDataCartedProductsStore(context: CoreDataContext.context())
        
        vc.cartDelegate = cartStore
        vc.deleteDelegate = likedStore
        vc.likeDelegate = likedStore
        vc.checkerDelegate = likedStore
        vc.productIndex = index
        
        return vc
    }
}
