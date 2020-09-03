//
//  IndividualResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 5/3/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct IndividualResponse: Decodable {
    var pending: Int?
    var shipping: Int?
    var purchased: Int?
}
