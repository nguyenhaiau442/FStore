//
//  ProductAttributeResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 5/20/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

class ProductAttributeResponse: Decodable {
    var attributeId: Int?
    var productId: Int?
    var attributeName: String?
}
