
import UIKit

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    public func setUpTabBar() {
        let context = CoreDataContext.context()
        
        let homeProductsVC = ProductsUIComposer.make(with: RemoteProductsLoader())
        let likedProductsVC = ProductsUIComposer.make(with: CoreDataLikedProductsStore(context: context))
        let cartProductsVC = CartViewComposer.createCartPage(with: CoreDataCartedProductsStore(context: context))

        homeProductsVC.title = "Products"
        likedProductsVC.title = "Liked"
        
        homeProductsVC.navigationItem.largeTitleDisplayMode = .automatic
        likedProductsVC.navigationItem.largeTitleDisplayMode = .automatic
        cartProductsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: homeProductsVC)
        let nav2 = UINavigationController(rootViewController: likedProductsVC)
        let nav3 = UINavigationController(rootViewController: cartProductsVC)
        
        for nav in [nav1,nav2,nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Liked", image: UIImage(systemName: "heart"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 3)
        
        setViewControllers([nav1,nav2,nav3], animated: true)
        
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if self.selectedIndex == 0 {
            let rootView = self.viewControllers![self.selectedIndex] as! UINavigationController
            rootView.popToRootViewController(animated: false)
        }
    }

}
