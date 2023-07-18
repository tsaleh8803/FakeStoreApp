//
//  DetailsViewController.swift
//  FakeStoreProject
//
//  Created by Mac on 14/07/2023.
//

import UIKit

class DetailsViewController: UITableViewController {

    var product: Product!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        navigationController?.navigationBar.scrollEdgeAppearance = nil
        productDetails(product: product)
    }
    
    private func productDetails(product: Product) {
        titleLabel.text = product.title
        categoryLabel.text = product.category
        priceLabel.text = String(product.price)
        descriptionLabel.text = product.description
        productImage.downloaded(from: URL(string: product.image)!)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
}
