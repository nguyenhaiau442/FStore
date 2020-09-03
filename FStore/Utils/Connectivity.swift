//
//  Connectivity.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 5/6/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
