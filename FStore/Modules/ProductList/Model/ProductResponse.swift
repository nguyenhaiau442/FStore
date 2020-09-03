//
//  ProductResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/18/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct ProductResponse: Decodable {
    var id: Int?
    var orderId: Int?
    var name: String?
    var price: Float?
    var isSale: Int?
    var salePrice: Float?
    var thumbnailUrl: String?
    var rating: Double?
    var comment: Int?
    var quantity: Int?
    var attributeId: Int?
}
