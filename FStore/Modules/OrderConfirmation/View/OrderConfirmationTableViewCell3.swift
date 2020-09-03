//
//  OrderConfirmationTableViewCell3.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/19/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

class OrderConfirmationTableViewCell3: OrderConfirmationTableViewCell2 {
    
    override var item: OrderConfirmationResponse? {
        didSet {            
            if (defaults2.value(forKey: Keys.shippingMethodId) as? Int) == 1 {
                shippingMethodLabel.text = "Giao hàng tiêu chuẩn"
            }
            if (defaults2.value(forKey: Keys.shippingMethodId) as? Int) == 2 {
                shippingMethodLabel.text = "Giao hàng nhanh"
            }
        }
    }
    
    let defaults2 = UserDefaults.standard
    
    let shippingMethodLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.numberOfLines = 0
        return l
    }()
    
    override func configureComponents() {
        accessoryType = .disclosureIndicator
        configureTitleLabel()
        contentView.addSubview(shippingMethodLabel)
        shippingMethodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        shippingMethodLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        shippingMethodLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        shippingMethodLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
}
