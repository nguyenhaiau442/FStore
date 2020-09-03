//
//  ProductFavouriteTableViewController.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 3/16/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ProductFavouriteTableViewController: UITableViewController {
    
    // MARK:- Variable Define
    private let cellId = "cellId"
    let defaults = UserDefaults.standard
    var products: [ProductResponse]? {
        didSet {
            if products?.count == 0 {
                let emptyView = EmptyView()
                emptyView.noticeString = "Hãy 🧡 sản phẩm bạn yêu thích khi mua sắm để xem lại thuận tiện nhất"
                self.tableView.backgroundView = emptyView
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.register(ProductFavouriteTableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    // MARK:- Navigation
    private func setupNavBar() {
        navigationItem.title = "Yêu Thích"
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-back"), style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchData() {
        guard let url = URL(string: PRODUCT_FAVOURITE_API_URL) else { return }
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
    
    private func removeFavourite(productId: Int) {
        guard let url = URL(string: REMOVE_FAVOURITE_PRODUCT_API_URL) else { return }
        let parameters: Parameters = ["userId": defaults.value(forKey: Keys.id)!, "productId": productId]
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { [unowned self] (response) in
            if let value = response.result.value as? NSDictionary {
                if let error = value["error"] as? Bool {
                    if error == false {
                        self.fetchData()
                        SVProgressHUD.dismiss()
                    }
                }
            }
        }
    }
    
}

// MARK:- Extension
extension ProductFavouriteTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductFavouriteTableViewCell
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Bỏ Thích") { [unowned self] (action, indexPath) in
            let productId = self.products?[indexPath.row].id
            self.removeFavourite(productId: productId!)
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
}
