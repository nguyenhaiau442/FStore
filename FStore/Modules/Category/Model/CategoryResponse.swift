//
//  CategoryResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 2/23/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct CategoryResponse: Decodable {
    var id: Int?
    var name: String?
    var bannerUrl: String?
    var categories: [ChildCategoryResponse]?
}

struct ChildCategoryResponse: Decodable {
    var id: Int?
    var name: String?
    var thumbnailUrl: String?
}
