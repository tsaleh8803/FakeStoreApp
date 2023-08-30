
import UIKit
import CoreData

final class ProductCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ProductsView, UICollectionViewDelegateFlowLayout {
    
    var products = [Product]() {
        didSet {
            if isViewLoaded {
                collectionView.reloadData()
            }
        }
    }
    
    var likedProductsLoader: ProductsLoader!
    
    var checkerDelegate: LikedProductChecker?
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.row]
        cell.nameLabel.text = product.title
        cell.priceLabel.text = "$\(String(product.price))"
        cell.productImageView.downloaded(from: URL(string: product.image)!)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-50)/2
        return CGSize(width: width, height: width*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewComposer.createDetailsPage(product: products[indexPath.row], index: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


