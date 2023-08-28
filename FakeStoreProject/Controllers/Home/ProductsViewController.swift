
import UIKit
import CoreData

final class ProductsViewController: UIViewController  {

    @IBOutlet weak var toggleView: UISegmentedControl!
    
    var listViewController: UIViewController?
    var collectionViewController: UIViewController?
    
    var productList = [Product]()
    
    var productsLoader: ProductsLoader!
    
    var childViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        productsLoader.fetchProducts { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                self.productList = products
                    self.setUp()
            }
            case .failure(let error):
                print(String(describing: error))
            }
        }

    }
    
    private func setUp() {
        listViewController = ProductsUIComposer.displayTableViewProducts(products: productList)
        collectionViewController = CollectionViewComposer.displayCollectionViewProducts(products: productList)
        
        if let listView = listViewController, let collecView = collectionViewController {
            self.addChild(listView)
            self.addChild(collecView)
            self.view.addSubview(listView.view)
            self.view.addSubview(collecView.view)
            
            listView.didMove(toParent: self)
            collecView.didMove(toParent: self)
            
            listView.view.frame = self.view.bounds
            collecView.view.frame = self.view.bounds
            
            collecView.view.isHidden = true
        }
    }

    @IBAction func viewToggleChanged(_ sender: Any) {
        
        listViewController?.view.isHidden = true
        collectionViewController?.view.isHidden = true
        
        if toggleView.selectedSegmentIndex == 0 {
            listViewController?.view.isHidden = false
            //listViewController = ProductsUIComposer.displayTableViewProducts(products: productList)
            //self.navigationController?.pushViewController(listViewController!, animated: true)
        }
        else {
            collectionViewController?.view.isHidden = false
            //collectionViewController = CollectionViewComposer.displayCollectionViewProducts(products: productList)
            //self.navigationController?.pushViewController(collectionViewController!, animated: true)

        }
    }
}
