
import UIKit
import CoreData

final class ProductsViewController: UIViewController  {

    @IBOutlet weak var toggleView: UISegmentedControl!
    
    var productsLoader: ProductsLoader!
    var productList = [Product]()
    
    var changeDisplay: ((Int, [Product]) -> Void)?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        productsLoader.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.productList = products
                    self?.viewToggleChanged()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func display(_ productsView: ProductsView) {
        removeAllChildren()
        addChild(productsView)
        view.addSubview(productsView.view)
        productsView.didMove(toParent: self)
        productsView.view.frame = view.frame
    }

    @IBAction func viewToggleChanged() {
        changeDisplay?(toggleView.selectedSegmentIndex, productList)
    }
}

protocol ProductsView: UIViewController {
    var products: [Product] { get set }
}

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

extension UIViewController {
    func removeAllChildren() {
        let viewControllers = children
        
        for viewContoller in viewControllers{
            viewContoller.willMove(toParent: nil)
            viewContoller.view.removeFromSuperview()
            viewContoller.removeFromParent()
        }
    }
}
