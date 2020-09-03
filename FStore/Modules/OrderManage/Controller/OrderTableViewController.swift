//
//  OrderTableViewController.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/5/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD


class OrderTableViewController: UITableViewController {
    
    // MARK:- Variable Define
    private let cellId = "cellId"
    let defaults = UserDefaults.standard
    var orders: [OrderResponse]? {
        didSet {
            if orders?.count == 0 {
                let emptyView = EmptyView()
                emptyView.noticeString = "Bạn chưa có đơn hàng nào"
                tableView.backgroundView = emptyView
            }
        }
    }
    var orderStatus: Int?
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.tableFooterView = UIView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    // MARK:- Navigation
    private func setupNavBar() {
        if orderStatus == 1 {
            navigationItem.title = "Đang Xử Lý"
        }
        if orderStatus == 2 {
            navigationItem.title = "Đang Giao"
        }
        if orderStatus == 3 {
            navigationItem.title = "Thành Công"
        }
        if orderStatus == 4 {
            navigationItem.title = "Đã Huỷ"
        }
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-back"), style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Fetch Data
    private func fetchData() {
        guard let url = URL(string: ORDER_MANAGE_API_URL) else { return }
        let parameters: Parameters = ["userId": defaults.value(forKey: Keys.id)!, "orderStatus": orderStatus!]
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { [weak self] (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let orders = try decoder.decode([OrderResponse].self, from: data)
                        self?.orders = orders
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
extension OrderTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrderTableViewCell
        cell.order = orders?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetail = OrderDetailViewController()
        orderDetail.orderId = orders?[indexPath.item].orderId
        navigationController?.pushViewController(orderDetail, animated: true)
    }
    
}
