//
//  LikedProductsViewController.swift
//  FakeStoreProject
//
//  Created by Mac on 20/07/2023.
//

import UIKit
import CoreData

final class LikedProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let collectionView: UICollectionView!
    
    var likedProducts = [Product]()
    
    let likedProductsLoader: ProductsLoader!
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        title = "Liked"
        view.addSubview(collectionView)
        likedProductsLoader.fetchProducts { result in
            switch result {
            case .success(let success):
                self.likedProducts = success
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        likedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikedProductCollectionViewCell.identifier, for: indexPath) as? LikedProductCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(for: likedProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width*1.5)
    }
    
}
