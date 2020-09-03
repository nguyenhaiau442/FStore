//
//  UserResponse.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 4/27/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

struct UserResponse: Decodable {

    var id: Int?
    var name: String?
    var phone: Int?
    var email: String?
    var gender: Int?
    var accountType: Int?
    var avatarUrl: String?
    var birthday: String?

    
}
