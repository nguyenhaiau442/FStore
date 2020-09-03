//
//  ProductReviewTableViewController.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 3/16/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ProductReviewTableViewController: UITableViewController {
    
    // MARK:- Variable Define
    private let cellId = "cellId"
    let defaults = UserDefaults.standard
    var products: [ProductResponse]? {
        didSet {
            if products?.count == 0 {
                let emptyView = EmptyView()
                emptyView.noticeString = "Bạn chưa có sản phẩm để đánh giá"
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
        tableView.register(ProductReviewTableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    // MARK:- Navigation
    private func setupNavBar() {
        navigationItem.title = "Đánh Giá Sản Phẩm"
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-back"), style: .plain, target: self, action: #selector(handleBack))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchData() {
        guard let url = URL(string: PRODUCT_REVIEW) else { return }
        let parameters: Parameters = ["userId": defaults.value(forKey: Keys.id)!]
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { [weak self] (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let products = try JSONDecoder().decode([ProductResponse].self, from: data)
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
    
    func showReviewViewController(productImageUrl: String, productName: String, productId: Int, orderId: Int?) {
        let writeReviewProductViewController = WriteReviewProductViewController()
        writeReviewProductViewController.productImageUrl = productImageUrl
        writeReviewProductViewController.productName = productName
        writeReviewProductViewController.productId = productId
        writeReviewProductViewController.orderId = orderId
        navigationController?.pushViewController(writeReviewProductViewController, animated: true)
    }
    
}

// MARK:- Extension
extension ProductReviewTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductReviewTableViewCell
        cell.product = products?[indexPath.row]
        cell.productReviewTableViewController = self
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
