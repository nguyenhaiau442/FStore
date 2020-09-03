//
//  ProvinceCityTableViewCell.swift
//  FStore
//
//  Created by Nguyễn Hải Âu on 5/11/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

class ProvinceCityTableViewCell: UITableViewCell {
    
    var provinceCity: ProvinceCityResponse? {
        didSet {
            if let name = provinceCity?.name {
                textLabel?.text = name
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = UIFont.systemFont(ofSize: 14)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
