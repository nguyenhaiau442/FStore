//
//  CommentResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/16/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct CommentResponse: Decodable {
    var rating: Int?
    var commentText: String?
    var userName: String?
    var createAt: String?
}

