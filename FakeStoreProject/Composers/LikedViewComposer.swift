

import Foundation
import UIKit

enum LikedViewComposer {
    
    public static func createLikedPage(with loader: LikedProductsLoader) -> UIViewController {
        let storyboard = UIStoryboard(name: "LikedProductsViewController", bundle: nil)
       // let vc = storyboard.instantiateInitialViewController() as! DetailsViewController
        let vc = storyboard.instantiateViewController(withIdentifier: "LikedProductsViewController") as! LikedProductsViewController
        
        vc.likedProductsLoader = loader
        return vc
    }
}
