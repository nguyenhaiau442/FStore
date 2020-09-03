//
//  Product.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 2/22/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct Product: Decodable {
    var id: Int?
    var name: String?
    var price: Float?
    var thumbnail_url: String?
    var images: [Image]?
    var is_sale: Int?
    var sale_price: Float?
    var rating: Float?
    var comment: Int?
    var quantity: Int?
    var title: String?
    var description: String?
    var comments: [CommentResponse]?
}

struct Image: Decodable {
    var imageUrl: String?
}
