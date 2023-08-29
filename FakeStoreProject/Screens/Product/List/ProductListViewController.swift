
import Foundation
import UIKit

final class ProductListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProductsView {
    
    private var contentOffset: CGPoint?
    
    @IBOutlet weak var tableView: UITableView!
    
    var scrollIndex: IndexPath?
            
    var products: [Product] = []
    var checkerDelegate: LikedProductChecker?
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func viewDidAppear(_ animated: Bool) {
        if let scrollIndex {
            tableView.scrollToRow(at: scrollIndex, at: .top, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.categoryLabel.text = product.category
        cell.priceLabel.text = "$\(String(product.price))"
        if let url = URL(string: product.image) {
            cell.productImage.downloaded(from: url )
        }
        cell.likedLabel.image = nil
        do{
            if try (checkerDelegate!.checkForLikedProduct(product: product)) {
                cell.likedLabel.image = UIImage(systemName: "heart.fill")
            }
        }
        catch {
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        scrollIndex = indexPath
        let vc = DetailsViewComposer.createDetailsPage(product: products[indexPath.row], index: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
