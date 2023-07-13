//
//  ViewController.swift
//  FakeStoreProject
//
//  Created by Mac on 13/07/2023.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var productList = [Product]()
    
    var productsLoader: ProductsLoader!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //URL that contains JSON data for all products
        productsLoader.fetchProducts { products in
            DispatchQueue.main.async {
                self.productList = products
                self.tableView.reloadData()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Products"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCell
        let product = productList[indexPath.row]
        
        cell.titleLabel.text = product.title
        cell.IDLabel.text = String(product.id)
        cell.categoryLabel.text = product.category
        cell.priceLabel.text = String(productList[indexPath.row].price)
        cell.descriptionLabel.text = productList[indexPath.row].description
        cell.productImage.downloaded(from: URL(string: productList[indexPath.row].image)!)
        
        return cell
    }
}

protocol ProductsLoader {
    func fetchProducts(completion: @escaping ([Product]) -> Void)
}
