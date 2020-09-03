//
//  HomeResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/17/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct HomeResponse: Decodable {
    var id: Int?
    var title: String?
    var banner: String?
    var products: [ProductResponse]?
}
