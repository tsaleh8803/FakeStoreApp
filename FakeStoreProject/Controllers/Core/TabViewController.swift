//
//  TabViewController.swift
//  FakeStoreProject
//
//  Created by Mac on 20/07/2023.
//

import UIKit

final class TabViewController: UITabBarController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        
        let homeProductsVC = ProductsUIComposer.make(with: RemoteProductsLoader())
        let likedProductsVC = ProductsUIComposer.make(with: CoreDataLikedProductsStore(context: context))
        let cartProductsVC = CartViewController()
     
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

}
