
import UIKit
import CoreData

final class ProductsViewController: UIViewController  {

    @IBOutlet weak var toggleView: UISegmentedControl!
    
    var productsLoader: ProductsLoader!
    
    var productList = [Product]() {
        didSet {
            (children.first as? ProductsView)?.products = productList
        }
    }
    
    var changeDisplay: ((Int, [Product]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewToggleChanged()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchAllProducts()
    }
    
    public func fetchAllProducts() {
        productsLoader.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.productList = products
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
        productsView.products = productList
    }

    @IBAction func viewToggleChanged() {
        changeDisplay?(toggleView.selectedSegmentIndex, productList)
    }
}

protocol ProductsView: UIViewController {
    var products: [Product] { get set }
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
