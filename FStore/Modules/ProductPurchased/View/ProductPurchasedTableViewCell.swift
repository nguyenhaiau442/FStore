//
//  ProductPurchasedTableViewCell.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/19/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

class ProductPurchasedTableViewCell: ProductTableViewCell {
    
    override func configureComponents() {
        configureProductImageView()
        configureNameLabel()
        configurePriceLabel()
        configureRatingView()
        configureTotalCommentLabel()
    }
    
    override func setupRatingView() {
        ratingView.isHidden = true
        if let rating = product?.rating {
            ratingView.isHidden = false
            ratingView.rating = Double(rating)
        }
    }
    
    override func configureRatingView() {
        contentView.addSubview(ratingView)
        ratingView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16).isActive = true
        ratingView.leftAnchor.constraint(equalTo: priceLabel.leftAnchor).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: 73).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
}
