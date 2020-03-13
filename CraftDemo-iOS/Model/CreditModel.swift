//
//  CreditModel.swift
//  CraftDemo-iOS
//
//  Created by Siddharth Suneel on 11/03/20.
//  Copyright © 2020 Siddharth Suneel. All rights reserved.
//

import Foundation
import UIKit

struct CreditModel: Codable {
    var score: Double?
    var start: String?
    var end: String?
    var date: String?
    
    var ranges = [CreditRangeModel]()
}

struct CreditRangeModel: Codable {
    var percentage: String?
    var startRange: Int?
    var endRange: Int?
    var hex: String?
    
    func getRangeText() -> String {
        if let start = startRange, let end = endRange {
            return "\(start) - \(end)"
        }
        return ""
    }
    
    func getColor() -> UIColor {
        if let hexString = hex {
            return UIColor.hexStringToUIColor(hex: hexString)
        }
        return UIColor.yellow
    }
}
