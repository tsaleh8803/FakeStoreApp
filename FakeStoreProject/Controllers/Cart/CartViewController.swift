
import UIKit

final class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cartProducts = [CartProduct]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var cartProductsLoader: CartProductsLoader!
    var quantityChangerDelegate: CartCellDelegate?
    var totalDelegate: CartTotalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        tableView.delegate = self
        tableView.dataSource = self
        updateTotal()
    }
    
    func updateTotal() {
        let newTotal = self.totalDelegate?.calculateTotal(cartProducts: self.cartProducts)
        if let newTotal {
            self.totalPriceLabel.text = "$\(String(newTotal))"
        }
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
        updateTotal()
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CartCell
        let product = cartProducts[indexPath.row]
                
        cell.nameLabel.text = product.title
        cell.priceLabel.text = "$\(String(product.price))"
        cell.productImageView.downloaded(from: URL(string: product.image)!)
        cell.quantityLabel.text = String(product.quantity)
       
       if (product.quantity == 1) {
           cell.minusButton.setTitle("", for: .normal)
           cell.minusButton.setImage(UIImage(systemName: "trash"), for: .normal)
       }
       else {
           cell.minusButton.imageView?.image = nil
       }
        
        cell.onIncreaseQuantity = {
            self.quantityChangerDelegate?.addQuantity(product: product, completion: { result in
                switch result {
                case .success(let cartProduct):
                    self.cartProducts[indexPath.row] = cartProduct
                    self.updateTotal()
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                case .failure(let failure):
                    print(String(describing: failure))
                }
            })
        }
        
        cell.onDecreaseQuantity = {
            if(product.quantity > 1) {
                self.quantityChangerDelegate?.minusQuantity(product: product, completion: { result in
                    switch result {
                    case .success(let cartProduct):
                        self.cartProducts[indexPath.row] = cartProduct
                        self.updateTotal()
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    case .failure(let failure):
                        print(String(describing: failure))
                    }
                })
            }
            if (product.quantity == 1) {
                self.cartProducts.remove(at: indexPath.row)
                try? self.quantityChangerDelegate?.removeProduct(product: product)
                self.updateTotal()
                tableView.reloadData()
            }
        }
        
        return cell
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts.count
    }

   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = Product(cartProduct: cartProducts[indexPath.row])
        let vc = DetailsViewComposer.createDetailsPage(product: product)
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

}
