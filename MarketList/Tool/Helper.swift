//
//  Helper.swift
//  MarketListModel
//
//  Created by Phan Nhat Dang on 9/24/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import Foundation

class Helper {
    static func dateToString(date:Date)->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        return dateString
    }
}
