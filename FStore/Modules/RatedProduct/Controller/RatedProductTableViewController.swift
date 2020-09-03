//
//  RatedProductTableViewController.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 3/16/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit
import Alamofire

class RatedProductTableViewController: UITableViewController {
    
    private let cellId = "cellId"
    let defaults = UserDefaults.standard
    var products: [RatedProductResponse]? {
        didSet {
            if products?.count == 0 {
                let emptyView = EmptyView()
                emptyView.noticeString = "Bạn chưa đánh giá sản phẩm nào"
                self.tableView.backgroundView = emptyView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(RatedProductTableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchData()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Đã Đánh Giá"
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-back"), style: .plain, target: self, action: #selector(handleBack))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchData() {
        guard let url = URL(string: RATED_PRODUCT_API_URL) else { return }
        let parameters: Parameters = ["userId": defaults.value(forKey: Keys.id)!]
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { [weak self] (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let products = try decoder.decode([RatedProductResponse].self, from: data)
                        self?.products = products
                        self?.tableView.reloadData()
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
extension RatedProductTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RatedProductTableViewCell
        cell.product = products?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
