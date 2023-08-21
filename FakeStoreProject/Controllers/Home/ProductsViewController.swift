
import UIKit
import CoreData

final class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
 
    
    @IBOutlet weak var tableView: UITableView!
    
    var productList = [Product]()
    
    var productsLoader: ProductsLoader!
    
    //var loadProducts: (() -> ((Result<[Product], Error>) -> Void))?

    var cart: CoreDataCartedProductsStore?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        productsLoader.fetchProducts { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                self.productList = products
                self.tableView.reloadData()
            }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        let product = productList[indexPath.row]
        
        cell.product = product
        cell.delegate = CoreDataCartedProductsStore(context: CoreDataContext.context())
        
        cell.titleLabel.text = product.title
        cell.categoryLabel.text = product.category
        cell.priceLabel.text = "$\(String(product.price))"
        cell.productImage.downloaded(from: URL(string: product.image)!)
        if product.isLiked {
            cell.likedLabel.image = UIImage(named:"heart")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailsViewComposer.createDetailsPage(product: productList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

}
