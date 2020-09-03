//
//  ProductDetailResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/13/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct ProductDetailResponse: Decodable {
    var id: Int?
    var name: String?
    var price: Float?
    var images: [Image]?
    var isSale: Int?
    var salePrice: Float?
    var rating: Float?
    var comment: Int?
    var title: String?
    var description: String?
    var comments: [CommentResponse]?
    var isFavourite: Bool?
    var isAttribute: Bool?
}
