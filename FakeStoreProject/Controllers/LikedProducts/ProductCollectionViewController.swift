
import UIKit
import CoreData

//MARK: - Collection View Alternative for Liked View Page
//(Currently not used)
final class ProductCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ProductsView {
    
    var products = [Product]()
    
    var likedProductsLoader: ProductsLoader!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        title = "Liked"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        likedProductsLoader.fetchProducts { result in
//            switch result {
//            case .success(let products):
//                self.productsList = products
//                self.collectionView.reloadData()
//            case .failure(let failure):
//                print(String(describing: failure))
//            }
//        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LikedProductCollectionViewCell
        let product = products[indexPath.row]
        cell.backgroundColor = .systemRed
        cell.nameLabel.text = product.title
        cell.priceLabel.text = String(product.price)
        cell.productImageView.downloaded(from: URL(string: product.image)!)
        
        return cell
    }
    
}
