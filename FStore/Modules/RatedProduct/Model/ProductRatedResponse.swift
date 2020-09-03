//
//  ProductRatedResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/10/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct RatedProductResponse: Decodable {
    var productId: Int?
    var rating: Int?
    var comment: String?
    var status: Int?
    var thumbnailUrl: String?
}
