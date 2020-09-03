//
//  OrderConfirmationResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 3/29/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct OrderConfirmationResponse: Decodable {
    var title: String?
    var products: [ProductResponse]?
    var id: Int?
    var name: String?
    var phone: Int?
    var street: String?
    var communeWardTown: String?
    var district: String?
    var provinceCity: String?
    var isDefault: Int?
    var formOfDelivery: Int?
    var paymentMethod: Int?
    var provisionalPrice: Float?
    var transportFee: Float?
}
