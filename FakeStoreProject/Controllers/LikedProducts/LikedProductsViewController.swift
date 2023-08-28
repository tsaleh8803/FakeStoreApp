
import UIKit
import CoreData

//MARK: - Collection View Alternative for Liked View Page
//(Currently not used)
final class LikedProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var likedProducts = [LikedProduct]()
    
    var likedProductsLoader: LikedProductsLoader!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        title = "Liked"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        likedProductsLoader.fetchLikedProducts { result in
            switch result {
            case .success(let products):
                self.likedProducts = products
                self.collectionView.reloadData()
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        likedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LikedProductCollectionViewCell
        let product = likedProducts[indexPath.row]
        cell.backgroundColor = .systemRed
        cell.nameLabel.text = product.title
        cell.priceLabel.text = String(product.price)
        cell.productImageView.downloaded(from: URL(string: product.image)!)
        
        return cell
    }
    
}
