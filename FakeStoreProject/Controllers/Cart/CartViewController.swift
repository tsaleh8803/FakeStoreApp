
import UIKit

final class CartViewController : UITableViewController  {
    
    var cartProducts = [CartProduct]()
    
    var cartProductsLoader: CartProductsLoader!
    var QuantityChangerDelegate: CartCellDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cartProductsLoader.fetchCartProducts(completion: { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                self.cartProducts = products
                self.tableView.reloadData()
            }
            case .failure(let error):
                print(String(describing: error))
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CartCell
        let product = cartProducts[indexPath.row]
                
        cell.nameLabel.text = product.title
        cell.priceLabel.text = "$\(String(product.price))"
        cell.productImageView.downloaded(from: URL(string: product.image)!)
        cell.quantityLabel.text = String(product.quantity)
        
        cell.onIncreaseQuantity = {
            print("increase for \(product.title)")
            self.QuantityChangerDelegate?.addQuantity(product: product, completion: { result in
                switch result {
                case .success(let cartProduct):
                    self.cartProducts[indexPath.row] = cartProduct
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                case .failure(let failure):
                    print(String(describing: failure))
                }
            })
        }
        
        cell.onDecreaseQuantity = {
            print("decrease for \(product.title)")
            self.QuantityChangerDelegate?.minusQuantity(product: product, completion: { result in
                switch result {
                case .success(let cartProduct):
                    self.cartProducts[indexPath.row] = cartProduct
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                case .failure(let failure):
                    print(String(describing: failure))
                }
            })
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts.count
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
