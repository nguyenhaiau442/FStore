//
//  OrderResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/6/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct OrderResponse: Decodable {
    var orderId: Int?
    var orderName: String?
    var orderDate: String?
    var orderStatus: Int?
}
