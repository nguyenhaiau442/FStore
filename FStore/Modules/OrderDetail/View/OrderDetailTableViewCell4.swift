//
//  OrderDetailTableViewCell4.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/20/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell4: OrderDetailTableViewCell3 {
    
    override var orderDetail: OrderDetailResponse? {
        didSet {
            if let paymentMethod = orderDetail?.paymentMethod {
                if paymentMethod == 1 {
                    typeLabel.text = "Thanh toán tiền mặt khi nhận hàng"
                }
                if paymentMethod == 2 {
                    typeLabel.text = "Thanh toán qua Thẻ tín dụng"
                }
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        titleLabel.text = "Hình thức thanh toán"
    }
    
}
