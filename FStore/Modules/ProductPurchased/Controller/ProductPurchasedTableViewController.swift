//
//  ProductPurchasedTableViewController.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 3/16/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ProductPurchasedTableViewController: UITableViewController {
    
    // MARK:- Variable Define
    private let cellId = "cellId"
    let defaults = UserDefaults.standard
    var products: [ProductResponse]? {
        didSet {
            if products?.count == 0 {
                let emptyView = EmptyView()
                emptyView.noticeString = "Bạn chưa mua sản phẩm nào"
                self.tableView.backgroundView = emptyView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.register(ProductPurchasedTableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchData()
    }
    
    // MARK:- Navigation
    private func setupNavBar() {
        navigationItem.title = "Đã Mua"
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-back"), style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Fetch Data
    private func fetchData() {
        guard let url = URL(string: PRODUCT_PURCHASED_API_URL) else { return }
        let parameters: Parameters = ["userId": defaults.value(forKey: Keys.id)!]
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { [weak self] (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let products = try decoder.decode([ProductResponse].self, from: data)
                        self?.products = products
                        self?.tableView.reloadData()
                        SVProgressHUD.dismiss()
                    }
                    catch let err {
                        print(err)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

// MARK:- Extension
extension ProductPurchasedTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductPurchasedTableViewCell
        cell.product = products?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.productId = products?[indexPath.item].id
        navigationController?.pushViewController(productDetailViewController, animated: true)
    }
    
}
