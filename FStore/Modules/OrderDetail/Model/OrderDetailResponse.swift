//
//  OrderDetailResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/8/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct OrderDetailResponse: Decodable {
    var title: String?
    var orderId: Int?
    var orderDate: String?
    var orderStatus: Int?
    var name: String?
    var phone: Int?
    var street: String?
    var communeWardTown: String?
    var district: String?
    var provinceCity: String?
    var shippingMethod: Int?
    var paymentMethod: Int?
    var products: [ProductResponse]?
    var provisionalPrice: Float?
    var transportFee: Float?
    var totalPrice: Float?
}
